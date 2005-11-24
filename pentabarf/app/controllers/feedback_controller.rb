class FeedbackController < ApplicationController
  before_filter :check_permission
  after_filter :compress

  def css
    @conference = Momomoto::Conference.find({:conference_id => 7})
    @response.headers['Content-Type'] = 'text/css'
    render_text(@conference.css.nil? ? "" : @conference.css)
  end

  def event
    @conference = Momomoto::Conference.find({:conference_id => @conference_id})
    @event = Momomoto::View_event.find({:event_id => @event_id, :language_id => @language_id})
    @content_title = "Feedback"
  end

  def save_event
    
  end

  protected

  def check_permission
    @conference_id = 7
    @event_id = 561
    @language_id = 120
    Momomoto::Base.ui_language_id = @language_id
    true
  end

end
