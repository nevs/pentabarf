class SubmissionController < ApplicationController
  before_filter :check_conference
  before_filter :authorize, :except => [:index, :logout]
  before_filter :check_permission, :except => [:index, :logout]
  before_filter :transparent_authorize
  after_filter :compress

  def index
    @content_title = "#{@conference.nil? ? '' : @conference.title + ' ' }Paper Submission"
    @conferences = Momomoto::Conference.select(:f_submission_enabled=>'t') if @conference.nil?
    Momomoto::Base.ui_language_id = 120;
  end

  def login
    redirect_to({:action=>:events,:conference=>@conference.acronym})
  end

  def person
    @content_title = 'Your Account Details'
    @person = Momomoto::Person.find({:person_id=>@user.person_id})
    @conference_person = Momomoto::Conference_person.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id})
    if @conference_person.nil?
      @conference_person.create
      @conference_person.conference_person_id = 0
    end
    @person_travel = Momomoto::Person_travel.find( {:person_id => @user.person_id,:conference_id => @conference.conference_id} )
    @person_travel.create if @person_travel.length == 0
  end

  def save_person
    transaction = Momomoto::Person_transaction.find( {:person_id => @user.person_id} )
    raise "Outdated Data!" if transaction.length == 1 && transaction.changed_when != params[:changed_when]

    raise "Passwords do not match" if params[:person][:password] != params[:password]
    person_allowed_fields = [:first_name, :last_name, :nickname, :public_name,
                             :title, :gender, :f_spam, :address, :street,
                             :street_postcode, :po_box, :po_box_postcode,
                             :city, :country_id, :iban, :bic, :bank_name, :account_owner]
    conference_person_allowed_fields = [:abstract, :description, :remark, :email_public]
    person_travel_allowed_fields = [:arrival_transport_id, :arrival_from, :arrival_to, 
                                    :arrival_number, :arrival_date, :arrival_time,:f_arrival_pickup,
                                    :departure_transport_id, :departure_from, :departure_to, 
                                    :departure_number, :departure_date, :departure_time,
                                    :f_departure_pickup, :travel_cost, :travel_currency_id, 
                                    :accommodation_cost, :accommodation_currency_id, :accommodation_name, 
                                    :accommodation_street, :accommodation_postcode, :accommodation_city, 
                                    :accommodation_phone, :accommodation_phone_room, :f_need_travel_cost,
                                    :f_need_accommodation_cost ]
    person = Momomoto::Person.find({:person_id=>@user.person_id})
    person.begin
    person_allowed_fields.each do | field |
      person[field] = params[:person][field]
    end
    person.password = params[:person][:password] if params[:person][:password].to_s.length > 0
    preferences = person.preferences
    preferences[:current_language_id] = params[:person][:preferences][:current_language_id].to_i
    person.preferences = preferences
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
    conference_person.f_reconfirmed = params[:conference_person][:f_reconfirmed] if @conference.f_reconfirmation_enabled
    modified = true if conference_person.write

    person_travel = Momomoto::Person_travel.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id})
    if person_travel.nil?
      person_travel.create
      person_travel.person_id = @user.person_id
      person_travel.conference_id = @conference.conference_id
      person_travel.fee_currency_id = @conference.currency_id
    end
    person_travel_allowed_fields.each do | field |
      person_travel[field] = params[:person_travel][field]
    end
    modified = true if person_travel.write

    if params[:person_im]
      person_im = Momomoto::Person_im.new
      params[:person_im].each do | key, value |
        next if value[:im_address].to_s == ''
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

  def events
    @content_title = 'Your Events'
    @events = Momomoto::Own_conference_events.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id})
    event_ids = []
    @events.each do | event | event_ids.push(event.event_id) end
    @events = Momomoto::View_event.find({:event_id=>event_ids,:translated_id=>@current_language_id,:conference_id=>@conference.conference_id}) unless @events.nil?
  end

  def event
    @content_title = 'Edit Event'
    if params[:id]
      @events = Momomoto::Own_conference_events.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id,:event_id=>params[:id]})
      return redirect_to(:action=>:events,:conference=>@conference.acronym) unless @events.length == 1
      @event = Momomoto::Event.find({:event_id=>params[:id]})
    else
      @event = Momomoto::Event.new_record
      @event.event_id = 0
    end
  end

  def save_event
    allowed_event_fields = [:title, :subtitle, :f_paper, :f_slides,
                            :language_id, :conference_track_id, :event_type_id,
                            :abstract, :description, :resources, :duration, :submission_notes]
    modified = false
    if params[:id]
      events = Momomoto::Own_conference_events.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id,:event_id=>params[:id]})
      return redirect_to(:action=>:events,:conference=>@conference.acronym) unless events.length == 1

      # check for outdated data
      transaction = Momomoto::Event_transaction.find( {:event_id => params[:id]} )
      raise "Outdated Data!" if transaction.length == 1 && transaction.changed_when != params[:changed_when]

      event = Momomoto::Event.find({:event_id=>params[:id]})
    else
      new_event = Momomoto::Submit_event.find({:person_id=>@user.person_id,:conference_id=>@conference.conference_id,:title=>params[:event][:title]})
      event = Momomoto::Event.find({:event_id=>new_event.new_event_id})
      modified = true
    end
    event.begin
    allowed_event_fields.each do | field |
      event[field] = params[:event][field]
    end
    modified = true if event.write

    if params[:link]
      event_link = Momomoto::Event_link.new
      params[:link].each do | key, value |
        next if value[:url].to_s == ''
        modified = true if save_or_delete_record( event_link, {:event_id => event.event_id, :event_link_id => value[:link_id]}, value)
      end
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

    if modified
      transaction = Momomoto::Event_transaction.new_record
      transaction.event_id = event.event_id
      transaction.changed_by = @user.person_id
      transaction.write
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
    elsif params[:conference]
      @conference.select({:acronym => params[:conference], :f_submission_enabled => 't'})
    end
    return @conference.length == 1 ? true : redirect_to({:action=>:index,:conference=>nil})
  end

  def check_permission
    return @user.permission?('submission_login')
  end

end
