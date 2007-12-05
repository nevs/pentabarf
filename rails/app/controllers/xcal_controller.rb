class XcalController < ApplicationController

  before_filter :init
  after_filter :content_type

  def conference
    @conference = Conference.select_single({:conference_id=>params[:id]})
    @rooms = Conference_room.select({:conference_id=>@conference.conference_id})
    @events = View_schedule_calendar.select({:conference_id => @conference.conference_id, :translated => @current_language})
    @filename = "#{@conference.acronym}.xcs"
  end

  protected

  def init
    @current_language = 'en'
  end

  def content_type
    if @filename
      response.headers['Content-Type'] = 'application/calendar+xml'
      response.headers['Content-Disposition'] = "attachment; filename=\"#{@filename}\""
    end
  end

end
