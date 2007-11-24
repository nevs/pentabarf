class ReportController < ApplicationController
  before_filter :init

  REPORTS = [:expenses,:feedback,:paper,:resources]

  def index
  end

  def expenses
    @report_class = View_report_expenses
  end

  def paper
  end

  def feedback
    @rows = View_report_feedback.select({:conference_id=>@current_conference.conference_id})
  end

  def resources
    @rows = View_report_resources.select({:conference_id=>@current_conference.conference_id})
  end

  [].each do | report |
    define_method( report ) do
      @report_class = Object.const_get("View_report_#{report}")
      render(:action => 'report')
    end
  end

  protected

  def init
    @content_title = "Reports"
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @current_language = POPE.user.current_language
  end

end
