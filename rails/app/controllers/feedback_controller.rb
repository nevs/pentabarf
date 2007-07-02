class FeedbackController < ApplicationController

  def css
    response.headers['Content-Type'] = 'text/css'
    render(:text=>@conference.css.to_s)
  end

  protected

  def auth
    @conference = Conference.select_single({:acronym=>params[:conference],:f_feedback_enabled=>'t'})
  end

end
