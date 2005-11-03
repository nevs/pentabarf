class ScheduleController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :compress

  def index

  end
  
  def day
    @day = params[:id].to_i
    @content_title = "Day #{@day}"
    @rooms = Momomoto::View_room.find({:conference_id=>@conference.conference_id, :language_id=>120}, nil, 'rank')
    @events = Momomoto::View_schedule_event.find({:conference_id=>@conference.conference_id,:translated_id=>120}, nil, 'lower(title),lower(subtitle)' )
  end
  
  def speaker 
    @content_title = "Speaker and moderators"
    @speaker = Momomoto::View_schedule_person.find({:conference_id=>@conference.conference_id}, nil, 'lower(name)')
  end

  def events
    @content_title = "Lectures and workshops"
    @events = Momomoto::View_schedule_event.find({:conference_id=>@conference.conference_id,:translated_id=>120}, nil, 'lower(title),lower(subtitle)' )
  end

  def css
    @response.headers['Content-Type'] = 'text/css'
    render_text(@conference.css.nil? ? "" : @conference.css)
  end

  def check_permission
    @conference = Momomoto::Conference.new
    if params[:conference_id].to_s.match(/^\d+$/)
      @conference.select({:conference_id => params[:conference_id]})
    else
      @conference.select({:acronym => params[:conference_id]})
    end
    return @conference.length == 1 ? true : false
  end

end
