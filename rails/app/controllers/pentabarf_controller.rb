class PentabarfController < ApplicationController

  before_filter :init
  after_filter :set_content_type

  def conflicts
    @conflicts = []
    @conflicts += View_conflict_person.call({:conference_id => @current_conference.conference_id, :language_id => @current_language_id })
    @conflicts += View_conflict_event.call({:conference_id => @current_conference.conference_id, :language_id => @current_language_id })
    @conflicts += View_conflict_event_event.call({:conference_id => @current_conference.conference_id, :language_id => @current_language_id })
    @conflicts += View_conflict_event_person.call({:conference_id => @current_conference.conference_id, :language_id => @current_language_id })
    @conflicts += View_conflict_event_person_event.call({:conference_id => @current_conference.conference_id, :language_id => @current_language_id })
  end

  def index
  end

  def conference
    begin
      @conference = Conference.select_single( :conference_id => params[:id] )
      @content_title = @conference.acronym
    rescue
      @content_title = "New Conference"
      return redirect_to(:action=>:conference,:id=>'new') if params[:id] != 'new'
      @conference = Conference.new(:conference_id=>0)
    end
  end

  def save_conference
    params[:conference][:conference_id] = params[:id] if params[:id].to_i > 0
    Momomoto::Database.instance.transaction do
      conf = write_row( Conference, params[:conference], {:except=>[:conference_id],:always=>[:f_submission_enabled,:f_visitor_enabled,:f_feedback_enabled,:f_reconfirmation_enabled]} )
      write_rows( Conference_language, params[:conference_language], {:preset=>{:conference_id => conf.conference_id}})
      write_rows( Team, params[:conference_team], {:preset=>{:conference_id => conf.conference_id}})
      write_rows( Conference_track, params[:conference_track], {:preset=>{:conference_id => conf.conference_id}})
      write_rows( Room, params[:conference_room], {:preset=>{:conference_id => conf.conference_id},:always=>[:f_public]})

      redirect_to( :action => :conference, :id => conf.conference_id)
    end
  end

  def event
    begin
      @event = Event.select_single( :event_id => params[:id] )
      @content_title = @event.title
    rescue
      return redirect_to(:action=>:event,:id=>'new') if params[:id] != 'new'
      @content_title = "New Event"
      @event = Event.new(:event_id=>0,:conference_id=>@current_conference.conference_id)
    end
    @event_rating = Event_rating.select_or_new({:event_id=>@event.event_id,:person_id=>POPE.user.person_id})
    @conference = Conference.select_single( :conference_id => @event.conference_id )
  end

  def save_event
    params[:event][:event_id] = params[:id] if params[:id].to_i > 0
    Momomoto::Database.instance.transaction do
      event = write_row( Event, params[:event], {:except=>[:event_id],:always=>[:f_public]} )
      write_row( Event_rating, params[:event_rating], {:preset=>{:event_id => event.event_id,:person_id=>POPE.user.person_id}})
      write_rows( Event_person, params[:event_person], {:preset=>{:event_id => event.event_id}})
      write_rows( Event_link, params[:event_link], {:preset=>{:event_id => event.event_id}})
      write_rows( Event_link_internal, params[:event_link_internal], {:preset=>{:event_id => event.event_id}})

      redirect_to( :action => :event, :id => event.event_id )
    end
  end

  def person
    begin
      @person = View_person.select_single( :person_id => params[:id] )
      @content_title = @person.name
    rescue
      return redirect_to(:action=>:person,:id=>'new') if params[:id] != 'new'
      @content_title = "New Person"
      @person = Person.new(:person_id=>0)
    end
    @conference = @current_conference
    @conference_person = Conference_person.select_or_new({:conference_id=>@conference.conference_id, :person_id=>@person.person_id})
    @person_travel = Person_travel.select_or_new({:conference_id=>@conference.conference_id, :person_id=>@person.person_id})
    @person_rating = Person_rating.select_or_new({:person_id=>@person.person_id,:evaluator_id=>POPE.user.person_id})
  end

  def save_person
    params[:person][:person_id] = params[:id] if params[:id].to_i > 0
    Momomoto::Database.instance.transaction do
      person = write_row( Person, params[:person], {:except=>[:person_id,:password,:password2],:always=>[:f_spam]} )
      conference_person = write_row( Conference_person, params[:conference_person], {:preset=>{:person_id => person.person_id,:conference_id=>@current_conference.conference_id}})
      write_row( Person_travel, params[:person_travel], {:preset=>{:person_id => person.person_id,:conference_id=>@current_conference.conference_id}})
      write_row( Person_rating, params[:person_rating], {:preset=>{:person_id => person.person_id,:evaluator_id=>POPE.user.person_id}})
      write_rows( Person_language, params[:person_language], {:preset=>{:person_id => person.person_id}})
      write_rows( Conference_person_link, params[:conference_person_link], {:preset=>{:conference_person_id => conference_person.conference_person_id}})
      write_rows( Conference_person_link_internal, params[:conference_person_link_internal], {:preset=>{:conference_person_id => conference_person.conference_person_id}})
      write_rows( Person_im, params[:person_im], {:preset=>{:person_id => person.person_id}})
      write_rows( Person_phone, params[:person_phone], {:preset=>{:person_id => person.person_id}})
      write_rows( Event_person, params[:event_person], {:preset=>{:person_id => person.person_id}})

      write_person_availability( @current_conference, params[:person_availability])

      redirect_to( :action => :person, :id => person.person_id )
    end
  end

  def activity
    @last_active = View_last_active.select( {:login_name => {:ne => POPE.user.login_name}}, {:limit => 12} )
    render(:partial=>'activity')
  end

  def recent_changes
    @content_title = "Recent Changes"
    @changes = View_recent_changes.select( {}, {:limit => 25 } )
  end

  def find_person
    @content_title = "Find Person"
  end

  def search_person_simple
    @results = View_find_person.select(params[:id] ? {:name=>{:ilike => params[:id].to_s.split(/ +/).map{|s| "%#{s}%"}}} : {} )
    render(:partial=>'search_person_simple')
  end

  def find_event
    @content_title = "Find Event"
  end

  def search_event_simple
    @results = View_find_event.select(params[:id] ? {:title=>{:ilike => params[:id].to_s.split(/ +/).map{|s| "%#{s}%"}}} : {:translated_id=>@current_language_id} )
    render(:partial=>'search_event_simple')
  end

  def find_conference
    @content_title = "Find Conference"
  end

  def search_conference_simple
    @results = View_find_conference.select(params[:id] ? {:title=>{:ilike => params[:id].to_s.split(/ +/).map{|s| "%#{s}%"}}} : {} )
    render(:partial=>'search_conference_simple')
  end

  protected

  def init
    # FIXME: remove hardcoded conference and language
    @current_conference = Conference.select_single(:conference_id => 1)
    @current_language_id = 120
  end

  def set_content_type
    # FIXME: jscalendar does not work with application/xml
    response.headers['Content-Type'] = 'text/html'
  end

end

