class FeedbackController < ApplicationController

  before_filter :init

  def css
    response.headers['Content-Type'] = Mime::CSS
    render(:text=>@conference.css.to_s)
  end

  def event
    @event = @conference.events({:event_id=>params[:id],:translated=>@current_language})[0]
    raise StandardError unless @event
    @event_feedback = Event_feedback.new
  end

  def save_event
    @event = @conference.events({:event_id=>params[:id],:translated=>@current_language})[0]
    raise StandardError unless @event
    write_row( Event_feedback, params[:event_feedback], {:preset=>{:event_id=>@event.event_id}} )
    redirect_to( :action=>:thankyou, :id => @event.event_id, :conference=>@conference.acronym, :language=>@current_language )
  end

  def thankyou
    @event = @conference.events({:event_id=>params[:id],:translated=>@current_language})
    raise StandardError unless @event
  end

  protected

  def init
    @current_language  = params[:language] || 'en'
  end

  def auth
    begin
      @conference = Release::Conference.select_single({:acronym=>params[:conference]},{:limit=>1,:order=>Momomoto.desc(:conference_release_id)})
    rescue Momomoto::Nothing_found
      @conference = Release_preview::Conference.select_single({:acronym=>params[:conference]})
    end
    if not @conference.f_feedback_enabled
      render(:text=>"There is currently no feedback enabled for a conference with this name.",:status=>404)
      return false
    end
    true
  end

end
