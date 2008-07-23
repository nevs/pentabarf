class ReportController < ApplicationController
  before_filter :init
  around_filter :update_last_login

  REPORTS = [:arrived,:not_arrived,:pickup,:expenses,:feedback,:missing,:paper,:slides,:resources,:review]

  def index
  end

  REPORTS.each do | report |
    define_method( report ) do
      @content_title = "#{params[:action].capitalize} Report"
      @rows = "View_report_#{report}".constantize.select({:conference_id=>@current_conference.conference_id})
    end
  end

  def pickup
    @content_title = "Pickup Report"
    @rows = View_report_pickup.select(:conference_id=>@current_conference.conference_id,:translated=>POPE.user.current_language)
  end

  def review
    @content_title = "Review Report"
    @events = View_report_review.select(:conference_id=>@current_conference.conference_id,:translated=>POPE.user.current_language)
    @ratings = Event_rating.select({:person_id=>POPE.user.person_id}).select{|r| r.remark || r.relevance || r.acceptance || r.actuality }.map{|r| r.event_id}
  end

  protected

  def init
    @content_title = 'Reports'
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @current_language = POPE.user.current_language
  end

end
