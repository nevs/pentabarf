class XcalController < ApplicationController
  before_filter :check_permission
  after_filter :content_type

  def conference
    @conference = Conference.find({:conference_id => params[:id]})
    @rooms = View_room.find({:conference_id=>@current_conference_id, :language_id=>@current_language_id})
    @events = View_schedule_event.find({:conference_id => @conference.conference_id, :translated_id => @current_language_id})
  end

  protected

  def check_permission
    POPE.permission?('pentabarf_login')
  end

  def content_type
    response.headers['Content-Type'] = 'application/calendar+xml'
    response.headers['Content-Disposition'] = "attachment; filename=\"#{@conference.acronym}.xcs\""
  end

end
