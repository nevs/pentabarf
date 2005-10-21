class IcalController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :fold
  after_filter :compress

  def conference
    @conference = Momomoto::Conference.find({:conference_id => params[:id]})
    @events = Momomoto::View_schedule.find({:conference_id => @conference.conference_id, :translated_id => @current_language_id})
    @timezone = 'Europe/Berlin'
    @response.headers['Content-Type'] = 'text/calendar'   
    @response.headers['Content-Disposition'] = "attachment; filename=\"#{@conference.acronym}.ics\""
    render_text(file.data)
  end
  
  protected

  def check_permission
    #redirect_to :action => :meditation if params[:action] != 'meditation'
    if @user.permission?('login_allowed') || params[:action] == 'meditation'
      @preferences = @user.preferences
      @current_conference_id = @preferences[:current_conference_id]
      @current_language_id = @preferences[:current_language_id]
    else
      redirect_to( :action => :meditation )
      false
    end
  end

end
