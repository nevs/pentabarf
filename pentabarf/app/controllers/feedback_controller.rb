class FeedbackController < ApplicationController
  before_filter :check_conference
  before_filter :check_event, :only => [:event, :save_event, :thankyou]
  after_filter :compress

  def css
    @response.headers['Content-Type'] = 'text/css'
    render_text(@conference.css.nil? ? "" : @conference.css)
  end

  def event
    @content_title = "Feedback"
  end

  def save_event
    @rating = Momomoto::Event_rating_public.new_record
    @rating.event_id = @event.event_id
    @rating.participant_knowledge = params['participant_knowledge']
    @rating.topic_importance = params['topic_importance']
    @rating.content_quality = params['content_quality']
    @rating.presentation_quality = params['presentation_quality']
    @rating.audience_involvement = params['audience_involvement']
    @rating.remark = params['remark']
    @rating.rater_ip = @request.env['REMOTE_ADDR']
    @rating.eval_time = 'now()'
    @rating.write
    redirect_to({:action=>:thankyou,:conference_id=>@conference.acronym,:id=>"#{@event.event_id}.#{@language.tag}.html"})
  end

  def thankyou
    @content_title = "Thank you."
  end

  protected

  def check_conference
    if params[:conference_id].match(/^\d+$/)
      @conference = Momomoto::Conference.find({:conference_id => params[:conference_id]})
    else
      @conference = Momomoto::Conference.find({:acronym => params[:conference_id]})
    end
    return true if @conference.length == 1 && @conference.f_feedback_enabled == 't'
    false
  end

  def check_event
    if match = params[:id].to_s.match(/^(\d+)(\.([a-z]+))?(\.html)?/)
      if match[3]
        @language = Momomoto::Language.find({:tag => match[3], :f_localized => 't'})
      else
        @language = Momomoto::Language.find({:language_id => 120})
      end
      return false unless @language.length == 1
      Momomoto::Base.ui_language_id = @language.language_id
      event_id = match[1].to_i
      @event = Momomoto::View_schedule_event.find({:event_id => event_id, :conference_id => @conference.conference_id, :translated_id=> @language.language_id})
      return true if @event.length > 0
    end
    false
  end

end
