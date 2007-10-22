class XcalController < ApplicationController

  before_filter :init
  after_filter :content_type

  def conference
    @conference = Conference.select_single({:conference_id=>params[:id]})
    @rooms = View_room.select({:conference_id=>@conference.conference_id, :language_id=>@current_language_id})
    @events = View_schedule_event.select({:conference_id => @conference.conference_id, :translated_id => @current_language_id})
    @filename = "#{@conference.acronym}.xcs"
  end

  protected

  def init
    @current_language_id = 120
  end

  def content_type
    if @filename
      response.headers['Content-Type'] = 'application/calendar+xml'
      response.headers['Content-Disposition'] = "attachment; filename=\"#{@filename}\""
    end
  end

end
