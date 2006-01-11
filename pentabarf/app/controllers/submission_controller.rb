class SubmissionController < ApplicationController
  before_filter :check_conference, :except => :index
  before_filter :authorize, :except => [:index, :create_account, :new_account, :activate_account, :account_done, :logout]
  before_filter :check_permission, :except => [:index, :create_account, :new_account, :activate_account, :account_done, :logout]
  before_filter :transparent_authorize
  after_filter :compress

  def index
    @content_title = 'Submission'
    Momomoto::Base.ui_language_id = 120;
  end

  def login
    redirect_to({:action=>:index,:conference=>@conference.acronym})
  end

  def new_account
    @content_title = 'Create account'
  end

  def create_account
    raise "Passwords do not match" if params[:person][:password] != params[:password]
    raise "Invalid email address" unless params[:person][:email_contact].match(/[\w_.+-]+@([\w.+_-]+\.)+\w{2,3}$/)
    account = Momomoto::Create_account.find({:login_name=>params[:person][:login_name],:password=>params[:person][:password],:email_contact=>params[:person][:email_contact],:activation_string=>random_string})
    ApplicationController.jabber_message('test')

    Notifier::deliver_activate_account( account.login_name, account.email_contact, url_for({:action=>:activate_account,:conference=>@conference.acronym,:id=>account.activation_string}) )
    redirect_to({:action=>:account_done,:conference=>@conference.acronym})
  end

  def account_done

  end

  def activate_account
    raise "Invalid activation sequence." unless params[:id].length == 64
    Momomoto::Activate_account.find({:activation_string=>params[:id]})
    redirect_to({:action=>:login,:conference=>@conference.acronym})
  end

  def person
    @person = Momomoto::Person.find({:person_id=>@user.person_id})
    @person_travel = Momomoto::Person_travel.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id})
    @conference_person = Momomoto::Conference_person.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id})
  end

  def save_person
    raise "Passwords do not match" if params[:person][:password] != params[:password]
    person_allowed_fields = [:first_name, :last_name, :nickname, :public_name,
                             :title, :gender, :f_spam, :address, :street,
                             :street_postcode, :po_box, :po_box_postcode,
                             :city, :country_id]
    conference_person_allowed_fields = [:abstract, :description, :remark, :email_public]
    person = Momomoto::Person.find({:person_id=>@user.person_id})
    person.begin
    person_allowed_fields.each do | field |
      person[field] = params[:person][field]
    end
    person.password = params[:person][:password] if params[:person][:password].to_s.length > 0
    person.write
    conference_person = Momomoto::Conference_person.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id})
    conference_person.create if conference_person.nil?
    conference_person_allowed_fields.each do | field |
      conference_person[field] = params[:conference_person][field]
    end
    conference_person.write

    if params[:person_im]
      person_im = Momomoto::Person_im.new
      params[:person_im].each do | key, value |
        modified = true if save_or_delete_record( person_im, {:person_id => person.person_id, :person_im_id => value[:person_im_id]}, value)
      end
    end

    if params[:person_phone]
      person_phone = Momomoto::Person_phone.new
      params[:person_phone].each do | key, value |
        next if value[:phone_number].to_s == ''
        modified = true if save_or_delete_record( person_phone, {:person_id => person.person_id, :person_phone_id => value[:person_phone_id]}, value)
      end
    end

    if params[:person_language]
      language = Momomoto::Person_language.new
      params[:person_language].each do | key, value |
        modified = true if save_or_delete_record( language, {:person_id => person.person_id, :language_id => value[:language_id]}, value)
      end
    end

    if params[:link]
      person_link = Momomoto::Conference_person_link.new
      params[:link].each do | key, value |
        next if value[:url].to_s == ''
        modified = true if save_or_delete_record( person_link, {:conference_person_id => conference_person.conference_person_id, :conference_person_link_id => value[:link_id]}, value)
      end
    end

    person.commit
    redirect_to({:action=>:person, :conference=>@conference.acronym})
  end

  def events
    @events = Momomoto::Own_events.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id})
    event_ids = []
    @events.each do | event | event_ids.push(event.event_id) end
    @events = Momomoto::View_event.find({:event_id=>event_ids,:translated_id=>@current_language_id})
  end

  def event
    if params[:id]
      @events = Momomoto::Own_events.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id,:event_id=>params[:id]})
      return redirect_to(:action=>:events,:conference=>@conference.acronym) unless @events.length == 1
      @event = Momomoto::Event.find({:event_id=>params[:id]})
    else
      @event = Momomoto::Event.new_record
    end
  end

  def save_event
    allowed_event_fields = [:title, :subtitle, :tag, :f_paper, :f_slides,
                            :language_id, :conference_track_id, :event_type_id,
                            :abstract, :description, :resources, :duration]
    if params[:id]
      events = Momomoto::Own_events.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id,:event_id=>params[:id]})
      return redirect_to(:action=>:events,:conference=>@conference.acronym) unless events.length == 1
      event = Momomoto::Event.find({:event_id=>params[:id]})
    else
      event = Momomoto::Event.new_record
      event.conference_id = @conference.conference_id
      event.event_origin_id = Momomoto::Event_origin.find({:tag=>'submission'}).event_origin_id
      event.event_state_id = Momomoto::Event_state.find({:tag=>'undecided'}).event_state_id
      event.event_state_progress_id = Momomoto::Event_state_progress.find({:tag=>'new',:event_state_id=>event.event_state_id}).event_state_progress_id
    end
    event.begin
    allowed_event_fields.each do | field |
      event[field] = params[:event][field]
    end
    event.write

    unless params[:id] # add ourself as speaker for new events
      event_person = Momomoto::Event_person.new_record
      event_person.event_id = event.event_id
      event_person.person_id = @user.person_id
      event_person.event_role_id = Momomoto::Event_role.find({:tag=>'speaker'}).event_role_id
      event_person.event_role_state_id = Momomoto::Event_role_state.find({:tag=>'offer',:event_role_id=>event_person.event_role_id}).event_role_state_id
      event_person.write
    end

    if params[:attachment_upload]
      file = Momomoto::Event_attachment.new
      params[:attachment_upload].each do | key, value |
        next unless value[:data].size > 0
        file.create
        file.event_id = event.event_id
        file.attachment_type_id = value[:attachment_type_id]
        mime_type = Momomoto::Mime_type.find({:mime_type => value[:data].content_type.chomp})
        raise "mime-type not found #{value[:data].content_type}" if mime_type.length != 1
        file.mime_type_id = mime_type.mime_type_id
        file.filename = value[:filename].to_s != '' ? value[:filename] : File.basename(value[:data].original_filename).gsub(/[^\w0-9.-_]/, '')
        file.title = value[:title]
        file.data = value[:data].read
        file.f_public = value[:f_public] ? true : false
        modified = true if file.write
      end
    end

    if params[:event_attachment]
      attachment = Momomoto::Event_attachment.new
      params[:event_attachment].each do | key, value |
        modified = true if save_or_delete_record( attachment, {:event_attachment_id => key, :event_id => event.event_id}, value ) { | t |
          t.f_public = value[:f_public] ? true : false
        }
      end
    end

    event.commit
    redirect_to({:action=>:event,:id=>event.event_id,:conference=>@conference.acronym})
  end

  protected

  def check_conference
    return true if params[:conference].nil? && params[:action].to_sym == :index
    @conference = Momomoto::Conference.new
    if params[:conference].to_s.match(/^\d+$/)
      @conference.select({:conference_id => params[:conference], :f_submission_enabled => 't'})
    else
      @conference.select({:acronym => params[:conference], :f_submission_enabled => 't'})
    end
    return @conference.length == 1 ? true : redirect_to({:action=>:index,:conference=>nil})
  end

  def check_permission
    return @user.permission?('submission_login')
  end

  # authorize users transparently if login_name and password are sent
  def transparent_authorize()
    login_name, password = get_auth_data

    if @user.nil? && !login_name.empty? && !password.empty?
      @user = Momomoto::Login.authorize( login_name, password )
      @user = nil if @user.nil?
    end
    if @user
      Momomoto::Base.ui_language_id = @user.preferences[:current_language_id]
    else
      Momomoto::Base.ui_language_id = 120
    end
    @current_language_id = Momomoto::Base.ui_language_id
    return true
  end

  def random_string
    sprintf("%064X", rand(2**256))
  end

end
