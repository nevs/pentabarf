class XmlController < ApplicationController

  before_filter :init

  def schedule
    @conference = Conference.select_single({:acronym => params[:conference]})
    @rooms = Conference_room.select({:conference_id=>@conference.conference_id, :public=>'t'},{:order=>:rank})
    @events = View_schedule_event.select({:conference_id=>@conference.conference_id,:translated=>@current_language})
  end

  protected

  def init
    @current_language = 'en'
    response.content_type = Mime::XML
  end

end
