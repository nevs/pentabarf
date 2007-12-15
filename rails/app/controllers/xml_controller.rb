class XmlController < ApplicationController

  before_filter :init

  def schedule
    @conference = Conference.select_single({:conference_id => params[:id]})
    @days = Conference_day.select({:conference_id=>@conference.conference_id},{:order=>:conference_day})
    @rooms = Conference_room.select({:conference_id=>@conference.conference_id, :public=>'t'},{:order=>:rank})
    @events = View_schedule_event.select({:conference_id=>@conference.conference_id,:translated=>@current_language})
  end

  protected

  def init
    @current_language = 'en'
  end

end
