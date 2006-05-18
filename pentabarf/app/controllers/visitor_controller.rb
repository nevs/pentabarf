class VisitorController < ApplicationController
  before_filter :check_conference
  before_filter :authorize, :except => [:index, :logout]
  before_filter :check_permission, :except => [:index, :logout]
  before_filter :transparent_authorize
  after_filter :compress

  def index
    @content_title = "#{@conference.nil? ? '' : @conference.title + ' ' }Visitor System"
    Momomoto::Base.ui_language_id = 120;
  end

  def login
    redirect_to({:action=>:schedule,:conference=>@conference.acronym})
  end

  def conflicts
    @conflicts = Momomoto::View_conflict_attendee.find(:conference_id=>@conference.conference_id,:person_id=>@user.person_id)
    render(:partial=>'conflicts')
  end

  def person
    @content_title = 'Your Account Details'
    @person = Momomoto::Person.find({:person_id=>@user.person_id})
    @conference_person = Momomoto::Conference_person.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id})
    if @conference_person.nil?
      @conference_person.create
      @conference_person.conference_person_id = 0
    end
  end

  def save_person
    transaction = Momomoto::Person_transaction.find( {:person_id => @user.person_id} )
    raise "Outdated Data!" if transaction.length == 1 && transaction.changed_when != params[:changed_when]

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
    modified = true if person.write

    conference_person = Momomoto::Conference_person.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id})
    if conference_person.nil?
      conference_person.create
      conference_person.person_id = @user.person_id
      conference_person.conference_id = @conference.conference_id
    end
    conference_person_allowed_fields.each do | field |
      conference_person[field] = params[:conference_person][field]
    end
    modified = true if conference_person.write

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

    if modified
      transaction = Momomoto::Person_transaction.new_record
      transaction.person_id = @user.person_id
      transaction.changed_by = @user.person_id
      transaction.write
    end

    person.commit
    redirect_to({:action=>:person, :conference=>@conference.acronym})
  end

  def event
    @event = Momomoto::View_event.new
    if params[:id]
      @event.find({ :event_id=>params[:id],
                    :conference_id=>@conference.conference_id,
                    :event_state_tag=>'accepted',
                    :translated_id=>Momomoto::Base.ui_language_id})
      @content_title = @event.title
    end
    return redirect_to(:action=>:schedule,:conference=>@conference.acronym) if @event.nil?
  end

  def schedule
    @content_title = 'Schedule'
    @events = Momomoto::View_visitor_schedule.find({:conference_id => @conference.conference_id, :translated_id => @current_language_id})
    @attended = Momomoto::View_event_person.find({:conference_id=>@conference.conference_id,:language_id=>@current_language_id,:person_id=>@user.person_id,:event_role_tag=>'attendee'})
  end

  def toggle_attendee
    @event_person = Momomoto::View_event_person.find({:person_id=>@user.person_id,:event_id=>params[:id],:event_role_tag=>'attendee'})
    if @event_person.nil?
      Momomoto::Add_attendee.find({:event_id=>params[:id],:person_id=>@user.person_id})
    else
      Momomoto::Remove_attendee.find({:event_id=>params[:id],:person_id=>@user.person_id})
    end
    return render_text( @event_person.nil? ? "Remove" : "Add" )
  end

  def css
    @response.headers['Content-Type'] = 'text/css'
    render_text(@conference.css.nil? ? "" : @conference.css)
  end

  protected

  def check_conference
    return true if params[:conference].nil? && params[:action].to_sym == :index
    @conference = Momomoto::Conference.new
    if params[:conference].to_s.match(/^\d+$/)
      @conference.select({:conference_id => params[:conference], :f_visitor_enabled => 't'})
    elsif params[:conference]
      @conference.select({:acronym => params[:conference], :f_visitor_enabled => 't'})
    end
    return @conference.length == 1 ? true : redirect_to({:action=>:index,:conference=>nil})
  end

  def check_permission
    return @user.permission?('submission_login')
  end

end
