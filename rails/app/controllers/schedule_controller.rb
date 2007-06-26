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
    @rooms = View_room.select({:conference_id=>@conference.conference_id, :language_id=>@current_language_id, :f_public=>'t'})
    @events = View_schedule_event.select({:day=>{:le=>@day},:conference_id=>@conference.conference_id,:translated_id=>@current_language_id})
  end

  protected

  def init
    # XXX FIXME remove hardcoded conference and language
    @conference = Conference.select_single(:acronym=>params[:conference])
    @tracks = Conference_track.select(:conference_id=>@conference.conference_id)
    @current_language_id = 120
  end

end
