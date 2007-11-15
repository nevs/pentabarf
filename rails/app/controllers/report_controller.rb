class ReportController < ApplicationController
  before_filter :init

  REPORTS = [:expenses,:feedback,:resources]

  def index
  end

  def expenses
    @report_class = View_report_expenses
  end

  REPORTS.each do | report |
    next if ReportController.instance_methods(false).member?( report.to_s )
    define_method( report ) do
      @report_class = Object.const_get("View_report_#{report}")
      render(:action => 'report')
    end
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @current_language = POPE.user.current_language
  end

end
