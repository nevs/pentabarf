class PentabarfController < ApplicationController
  before_filter :set_conference
  after_filter :compress
  after_filter :set_content_type
  session(:off)

  def index
  end

  def person
    begin
      @person = Person.select_single( :person_id => params[:id].to_i )
    rescue
      return redirect_to(:action=>:person,:id=>'new') if params[:id] != 'new'
      @person = Person.new(:person_id=>0)
    end
  end

  def save_person
    params[:person][:person_id] = params[:id] if params[:id].to_i > 0
    Momomoto::Database.instance.transaction do
      person = write_row( Person, params[:person], {:except=>[:person_id]} )

      redirect_to( :action => :person, :id => person.person_id)
    end
  end

  def event
    begin
      @event = Event.select_single( :event_id => params[:id] )
    rescue
      return redirect_to(:action=>:event,:id=>'new') if params[:id] != 'new'
      @event = Event.new( :event_id => 0 )
      @event.conference_id = @current_conference.conference_id
    end
    @conference = Conference.select_single(:conference_id=>@event.conference_id)
  end

  def save_event
    params[:event][:event_id] = params[:id] if params[:id].to_i > 0
    Momomoto::Database.instance.transaction do
      event = write_row( Event, params[:event], {:except=>[:conference_id]} ) do | e |
        e.conference_id = @current_conference.conference_id if e.new_record?
      end
      write_rows( Event_person, params[:event_person], {:preset=>{:event_id => event.event_id}} )

      redirect_to( :action => :event, :id => event.event_id)
    end
  end

  def conference
    begin
      @conference = Conference.select_single( :conference_id => params[:id] )
    rescue
      return redirect_to(:action=>:conference,:id=>'new') if params[:id] != 'new'
      @conference = Conference.new(:conference_id=>0)
    end
  end

  def save_conference
    params[:conference][:conference_id] = params[:id] if params[:id].to_i > 0
    Momomoto::Database.instance.transaction do
      conf = write_row( Conference, params[:conference], {:except=>[:conference_id]} )
      write_rows( Conference_language, params[:conference_language], {:preset=>{:conference_id => conf.conference_id}})
      write_rows( Conference_track, params[:conference_track], {:preset=>{:conference_id => conf.conference_id}})
      write_rows( Conference_room, params[:conference_room], {:preset=>{:conference_id => conf.conference_id},:always=>[:public]})

      redirect_to( :action => :conference, :id => conf.conference_id)
    end
  end

  [:person, :event, :conference].each do | object |

    define_method("find_#{object}") do end

    define_method("search_#{object}") do
      render( :partial => "search_#{object}" )
    end

  end

  protected
  def set_conference
    @current_conference = Conference.select( {}, :order => :conference_id ).first || Conference.new
  end

  def authorized?
    # XXX implement real authorization check
    true
  end

  def set_content_type
    response.headers['Content-Type'] = 'text/html'
  end

end

