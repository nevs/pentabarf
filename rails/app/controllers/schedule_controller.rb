class ScheduleController < ApplicationController

  before_filter :init

  def index
  end

  def css
    response.headers['Content-Type'] = 'text/css'
    render( :text => @conference.css.to_s )
  end

  def day
    @day = params[:id].to_i
#    @content_title = "#{local(:schedule)} #{local(:day)} #{@day}"
    @rooms = View_room.select({:conference_id=>@conference.conference_id, :language_id=>@current_language_id, :f_public=>'t'})
    @events = View_schedule_event.select({:day=>{:le=>@day},:conference_id=>@conference.conference_id,:translated_id=>@current_language_id})
  end

  def days
#    @content_title = local(:schedule)
    @rooms = View_room.select({:conference_id=>@conference.conference_id, :language_id=>@current_language_id, :f_public=>'t'})
    @events = View_schedule_event.select({:conference_id=>@conference.conference_id,:translated_id=>@current_language_id})
  end

  def event
    @events = View_schedule_event.select({:conference_id=>@conference.conference_id,:translated_id=>@current_language_id})
    @event = View_event.select_single({:conference_id=>@conference.conference_id,:translated_id=>@current_language_id,:event_id=>params[:id]})
    @content_title = @event.title
  end

  protected

  def init
    # XXX FIXME remove hardcoded conference and language
    @conference = Conference.select_single(:acronym=>params[:conference])
    @tracks = Conference_track.select(:conference_id=>@conference.conference_id)
    @current_language_id = 120
  end

end
