class FeedbackController < ApplicationController

  before_filter :init

  def css
    response.headers['Content-Type'] = 'text/css'
    render(:text=>@conference.css.to_s)
  end

  def event
    @event = View_schedule_simple.select_single({:event_id => params[:id], :conference_id => @conference.conference_id})
    @event_feedback = Event_feedback.new
  end

  def save_event
    @event = View_schedule_simple.select_single({:event_id => params[:id], :conference_id => @conference.conference_id})
    write_row( Event_feedback, params[:event_feedback], {:preset=>{:event_id=>@event.event_id}} )
    redirect_to( :action=>:thankyou, :id => @event.event_id, :conference=>@conference.acronym, :language=>@current_language )
  end

  def thankyou
    @event = View_schedule_simple.select_single({:event_id => params[:id], :conference_id => @conference.conference_id})
  end

  protected

  def init
    @current_language  = params[:language] || 'en'
  end

  def auth
    @conference = Conference.select_single({:acronym=>params[:conference],:f_feedback_enabled=>'t'})
   rescue
    render(:text=>"There is currently no feedback enabled for a conference with this name.",:status=>404)
    false
  end

end
