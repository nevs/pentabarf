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
#      write_rows( Conference_room, params[:conference_room], {:preset=>{:conference_id => conf.conference_id},:always=>[:public]})

      redirect_to( :action => :conference, :id => conf.conference_id)
    end
  end

  def person
    begin
      @person = Person.select_single( :person_id => params[:id].to_i )
    rescue
      return redirect_to(:action=>:person,:id=>'new') if params[:id] != 'new'
      @person = Person.new(:person_id=>0)
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

