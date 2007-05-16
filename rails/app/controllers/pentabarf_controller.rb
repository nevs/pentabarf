class PentabarfController < ApplicationController

  before_filter :init
  after_filter :set_content_type

  def index
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
    rescue
      return redirect_to(:action=>:event,:id=>'new') if params[:id] != 'new'
      @event = Event.new(:event_id=>0)
    end
  end

  def person
    begin
      @person = Person.select_single( :person_id => params[:id].to_i )
    rescue
      return redirect_to(:action=>:person,:id=>'new') if params[:id] != 'new'
      @person = Person.new(:person_id=>0)
    end
    @conference_person = Conference_person.select_or_new({:conference_id=>@current_conference.conference_id, :person_id=>@person.person_id})
    @person_travel = Person_travel.select_or_new({:conference_id=>@current_conference.conference_id, :person_id=>@person.person_id})
  end

  def save_person
    params[:person][:person_id] = params[:id] if params[:id].to_i > 0
    Momomoto::Database.instance.transaction do
      person = write_row( Person, params[:person], {:except=>[:person_id],:always=>[:f_spam]} )
      conference_person = write_row( Conference_person, params[:conference_person], {:preset=>{:person_id => person.person_id,:conference_id=>@current_conference.conference_id}})
      write_row( Person_travel, params[:person_travel], {:preset=>{:person_id => person.person_id,:conference_id=>@current_conference.conference_id}})
      write_rows( Person_language, params[:person_language], {:preset=>{:person_id => person.person_id}})
      write_rows( Conference_person_link, params[:conference_person_link], {:preset=>{:conference_person_id => conference_person.conference_person_id}})
      write_rows( Person_im, params[:person_im], {:preset=>{:person_id => person.person_id}})
      write_rows( Person_phone, params[:person_phone], {:preset=>{:person_id => person.person_id}})

      redirect_to( :action => :person, :id => person.person_id )
    end
  end

  def activity
    @last_active = View_last_active.select( {:login_name => {:ne => POPE.user.login_name}}, {:limit => 12} )
    render(:partial=>'activity')
  end

  protected

  def init
    # XXX FIXME remove hardcoded conference
    @current_conference = Conference.select_single(:conference_id => 1)
  end

  def set_content_type
    # XXX FIXME jscalendar does not work with application/xml
    response.headers['Content-Type'] = 'text/html'
  end

end

