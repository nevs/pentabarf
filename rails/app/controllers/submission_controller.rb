class SubmissionController < ApplicationController

  before_filter :init
  before_filter :check_transaction, :only=>[:save_event]
  after_filter :set_content_type

  def index
    @conferences = Conference.select({:f_submission_enabled=>'t'})
  end

  def login
    redirect_to(:action=>:index,:id=>'auth')
  end

  def event
    if params[:id] && params[:id] != 'new'
      own = Own_conference_events.call({:person_id=>POPE.user.person_id,:conference_id=>@conference.conference_id},{:own_conference_events=>params[:id]})
      raise "You are not allowed to edit this event." if own.length != 1
      @event = Event.select_single({:event_id=>params[:id]})
    else
      @event = Event.new({:conference_id=>@conference.conference_id,:event_id=>0})
    end
    @attachments = View_event_attachment.select({:event_id=>@event.event_id,:language_id=>@current_language_id})
    @transaction = Event_transaction.select_single({:event_id=>@event.event_id}) rescue Event_transaction.new
  end

  def events
    own_events = Own_conference_events.call(:conference_id=>@conference.conference_id,:person_id=>POPE.user.person_id)
    own_events = own_events.map{|e| e.own_conference_events }
    if own_events.length > 0
      @events = View_event.select(:event_id=>own_events,:translated_id=>@current_language_id,:conference_id=>@conference.conference_id)
    else
      @events = []
    end
  end

  def save_event
    raise "Event title is mandatory" if params[:event][:title].empty?
    Momomoto::Database.instance.transaction do
      if params[:id].to_i == 0
        event = Submit_event.call(:e_person_id=>POPE.user.person_id,:e_conference_id=>@conference.conference_id,:e_title=>params[:event][:title])
        params[:id] = event[0].submit_event
        POPE.refresh
      end
      params[:event][:event_id] = params[:id]
      event = write_row( Event, params[:event], {:except=>[:event_id],:only=>Event::SubmissionFields} )
      write_rows( Event_link, params[:event_link], {:preset=>{:event_id => event.event_id},:ignore_empty=>:url})
      write_file_row( Event_image, params[:event_image], {:preset=>{:event_id => event.event_id},:image=>true})
      write_rows( Event_attachment, params[:event_attachment], {:always=>[:f_public]} )
      write_file_rows( Event_attachment, params[:attachment_upload], {:preset=>{:event_id=>event.event_id}})

      Event_transaction.new({:event_id=>event.event_id,:changed_by=>POPE.user.person_id}).write

      redirect_to( :action => :event, :id => event.event_id )
    end
  end

  def person
    @person = POPE.user
    @conference_person = Conference_person.select_or_new({:conference_id=>@conference.conference_id, :person_id=>@person.person_id})
    @person_travel = Person_travel.select_or_new({:conference_id=>@conference.conference_id, :person_id=>@person.person_id})
    @person_image = Person_image.select_or_new({:person_id=>@person.person_id})
    @transaction = Person_transaction.select_single({:person_id=>@person.person_id}) rescue Person_transaction.new
  end

  def save_person
    Momomoto::Database.instance.transaction do
      params[:person][:person_id] = POPE.user.person_id
      person = write_row( Person, params[:person], {:except=>[:person_id,:password,:password2],:always=>[:f_spam]} ) do | row |
        if params[:person][:password].to_s != ""
          raise "Passwords do not match" if params[:person][:password] != params[:person][:password2]
          row.password = params[:person][:password]
        end
      end
      conference_person = write_row( Conference_person, params[:conference_person], {:preset=>{:person_id => person.person_id,:conference_id=>@conference.conference_id}})
      POPE.refresh
      write_row( Person_travel, params[:person_travel], {:preset=>{:person_id => person.person_id,:conference_id=>@conference.conference_id}})
      write_rows( Person_language, params[:person_language], {:preset=>{:person_id => person.person_id}})
      write_rows( Conference_person_link, params[:conference_person_link], {:preset=>{:conference_person_id => conference_person.conference_person_id},:ignore_empty=>:url})
      write_rows( Person_im, params[:person_im], {:preset=>{:person_id => person.person_id}})
      write_rows( Person_phone, params[:person_phone], {:preset=>{:person_id => person.person_id},:ignore_empty=>:phone_number})

      write_file_row( Person_image, params[:person_image], {:preset=>{:person_id => person.person_id},:always=>[:f_public],:image=>true})
      write_person_availability( @conference, person, params[:person_availability])

      Person_transaction.new({:person_id=>person.person_id,:changed_by=>POPE.user.person_id}).write

      redirect_to( :action => :person )
    end
  end

  protected

  def init
    @conference = Conference.select_single(:acronym=>params[:conference],:f_submission_enabled=>'t') rescue nil
    @current_language_id = POPE.user.current_language_id rescue 120
  end

  def auth
    return super if params[:action] != 'index' || params[:id] == 'auth'
    true
  end

  def check_permission
    POPE.permission?('submission_login')
  end

  def set_content_type
    # FIXME: jscalendar does not work with application/xml
    response.headers['Content-Type'] = 'text/html'
  end

end
