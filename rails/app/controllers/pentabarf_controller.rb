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
