class ScheduleController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :compress

  def index

  end

  def day
    @day = params[:id].to_i
    @content_title = "Day #{@day}"
    @rooms = Momomoto::View_room.find({:conference_id=>@conference.conference_id, :language_id=>@current_language_id, :f_public=>'t'}, nil, 'rank')
    @events = Momomoto::View_schedule_event.find({:day=>{:le=>@day},:conference_id=>@conference.conference_id,:translated_id=>@current_language_id}, nil, 'lower(title),lower(subtitle)' )
  end

  def days
    @content_title = "Schedule Overview"
    @rooms = Momomoto::View_room.find({:conference_id=>@conference.conference_id, :language_id=>@current_language_id, :f_public=>'t'}, nil, 'rank')
    @events = Momomoto::View_schedule_event.find({:conference_id=>@conference.conference_id,:translated_id=>@current_language_id}, nil, 'lower(title),lower(subtitle)' )
  end

  def speaker
    @speakers = Momomoto::View_schedule_person.find({:conference_id=>@conference.conference_id}, nil, 'lower(name)')
    @person = Momomoto::View_person.find({:person_id=>params[:id]})
    @speaker = Momomoto::View_conference_person.find({:conference_id=>@conference.conference_id,:person_id=>params[:id]})
    @speaker.create if @speaker.length != 1
    return render_text("") unless @person.length == 1 && @speakers.find_by_value(:person_id=>@person.person_id)
    @content_title = @speaker.name
  end

  def speakers
    @content_title = "Speakers and moderators"
    @speakers = Momomoto::View_schedule_person.find({:conference_id=>@conference.conference_id}, nil, 'lower(name), lower(title), lower(subtitle)')
  end

  def event
    @events = Momomoto::View_schedule_event.find({:conference_id=>@conference.conference_id,:translated_id=>@current_language_id},nil,'lower(title),lower(subtitle),lower(name)')
    @event = Momomoto::View_event.find({:conference_id=>@conference.conference_id,:translated_id=>@current_language_id,:event_id=>params[:id]})
    return render_text("") unless @event.length == 1 && @events.find_by_value(:event_id => @event.event_id)
    @content_title = @event.title
  end

  def events
    @content_title = "Lectures and workshops"
    @events = Momomoto::View_schedule_event.find({:conference_id=>@conference.conference_id,:translated_id=>@current_language_id}, nil, 'lower(title),lower(subtitle)' )
  end

  def css
    @response.headers['Content-Type'] = 'text/css'
    render_text(@conference.css.nil? ? "" : @conference.css)
  end

  protected

  def check_permission
    @conference = Momomoto::Conference.new
    @current_language_id = @user.preferences[:current_language_id]
    if params[:conference_id].to_s.match(/^\d+$/)
      @conference.select({:conference_id => params[:conference_id]})
    else
      @conference.select({:acronym => params[:conference_id]})
    end
    return @conference.length == 1 ? true : false
  end

end

