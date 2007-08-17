class SubmissionController < ApplicationController

  before_filter :init
  after_filter :set_content_type

  def index
  end

  def person
  end

  def save_person
  end

  protected

  def init
    @conferences = Conference.select({:f_submission_enabled=>'t'})
    @conference = Conference.select_single(:acronym=>params[:conference]) rescue nil
    # FIXME: remove hardcoded language
    @current_language_id = 120
  end

  def check_permission
    return POPE.permission?('submission_login')
  end

  def set_content_type
    # FIXME: jscalendar does not work with application/xml
    response.headers['Content-Type'] = 'text/html'
  end

end
