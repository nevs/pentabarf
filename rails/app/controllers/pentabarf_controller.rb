class PentabarfController < ApplicationController
  
  before_filter :init
  after_filter :set_content_type

  def index
  end

  def conference
    params[:id] = 2
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
#      write_rows( Conference_track, params[:conference_track], {:preset=>{:conference_id => conf.conference_id}})
#      write_rows( Conference_room, params[:conference_room], {:preset=>{:conference_id => conf.conference_id},:always=>[:public]})

      redirect_to( :action => :conference, :id => conf.conference_id)
    end
  end

  def activity
    @last_active = View_last_active.select( {:login_name => {:ne => @user.login_name}}, {:limit => 12} )
    render(:partial=>'activity')
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => 2)
  end

  def set_content_type
    # XXX FIXME jscalendar does not work with application/xml
    response.headers['Content-Type'] = 'text/html'
  end

end
