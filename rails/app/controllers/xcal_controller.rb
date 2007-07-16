class XcalController < ApplicationController

  after_filter :content_type

  def conference
    @conference = Conference.find({:conference_id => params[:id]})
    @rooms = View_room.find({:conference_id=>@current_conference_id, :language_id=>@current_language_id})
    @events = View_schedule_event.find({:conference_id => @conference.conference_id, :translated_id => @current_language_id})
    @filename = "#{@conference.acronym}.xcs"
  end

  protected

  def content_type
    if @filename
      response.headers['Content-Type'] = 'application/calendar+xml'
      response.headers['Content-Disposition'] = "attachment; filename=\"#{@filename}\""
    end
  end

end
