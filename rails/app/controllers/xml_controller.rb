class XmlController < ApplicationController
  before_filter :check_permission

  def schedule
    @conference = Conference.select_single({:conference_id => @params[:id]})
    @rooms = View_room.select({:conference_id=>@conference.conference_id, :language_id=>@current_language_id, :f_public=>'t'},{:order=>:rank})
    @events = View_schedule_event.select({:conference_id=>@conference.conference_id,:translated_id=>@current_language_id}, nil, 'lower(title),lower(subtitle)' )
  end

  protected

  def check_permission
    POPE.permission?('pentabarf_login')
  end

end
