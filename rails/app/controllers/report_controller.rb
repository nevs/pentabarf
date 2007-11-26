class ReportController < ApplicationController
  before_filter :init

  REPORTS = [:expenses,:feedback,:missing,:paper,:resources]

  def index
  end

  REPORTS.each do | report |
    define_method( report ) do
      @content_title = "#{params[:action].capitalize} Report"
      @rows = "View_report_#{report}".constantize.select({:conference_id=>@current_conference.conference_id})
    end
  end

  protected

  def init
    @content_title = 'Reports'
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @current_language = POPE.user.current_language
  end

end
