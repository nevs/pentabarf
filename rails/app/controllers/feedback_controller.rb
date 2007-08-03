class FeedbackController < ApplicationController

  before_filter :init

  def css
    response.headers['Content-Type'] = 'text/css'
    render(:text=>@conference.css.to_s)
  end

  def event
    @language = Language.select_single({:tag=>params[:language]})
    @event = View_schedule_simple.select_single({:event_id => params[:id], :conference_id => @conference.conference_id})
    @event_rating = Event_rating_public.new
  end

  def save_event
    @event = View_schedule_simple.select_single({:event_id => params[:id], :conference_id => @conference.conference_id})
    @language = Language.select_single({:tag=>params[:language]})
    write_row( Event_rating_public, params[:event_rating_public], {:preset=>{:event_id=>@event.event_id}} )
    redirect_to( :action=>:thankyou, :id => @event.event_id, :conference=>@conference.acronym, :language=>@language.tag )
  end

  def thankyou
    @language = Language.select_single({:tag=>params[:language]})
    @event = View_schedule_simple.select_single({:event_id => params[:id], :conference_id => @conference.conference_id})
  end

  protected

  def init
  end

  def auth
    @conference = Conference.select_single({:acronym=>params[:conference],:f_feedback_enabled=>'t'})
  end

end
