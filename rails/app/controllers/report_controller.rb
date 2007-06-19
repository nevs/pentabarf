class ReportController < ApplicationController
  before_filter :init

  REPORTS = [:expenses]

  def index
  end
  
  def expenses
    @report_class = View_report_expenses
  end

  REPORTS.each do | report |
    next if true
    next if ReportController.instance_methods(false).member?(:expenses)
    define_method( report ) do 
      @report_class = Object.const_get("View_report_#{report}")
      render(:action => 'report')
    end
  end

  protected

  def init
    # XXX FIXME remove hardcoded conference and language
    @current_conference = Conference.select_single(:conference_id => 1)
    @current_language_id = 120
  end

end
