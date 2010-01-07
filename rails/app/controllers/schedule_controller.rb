class ScheduleController < ApplicationController

  include ScheduleHelper

  before_filter :init

  def index
    @content_title = @conference.title
  end

  def css
    response.content_type = Mime::CSS
    render( :text => @conference.css.to_s )
  end

  def day
    @day = @conference.days(:conference_day=>params[:id])[0]
    raise StandardError unless @day
    @content_title = "#{local('schedule::schedule')} #{@day.name}"
    @rooms = @conference.rooms
    @events = @conference.events({:conference_day=>{:le=>@day.conference_day},:translated=>@current_language},{:order=>[:title,:subtitle]})
  end

  def event
    @event = @conference.events({:translated=>@current_language,:event_id=>params[:id]})[0]
    raise StandardError unless @event
    @events = @conference.events({:translated=>@current_language},{:order=>[:title,:subtitle]})
    @content_title = @event.title
  end

  def event_attachment
    @event = @conference.events({:translated=>@current_language,:event_id=>params[:id]})[0]
    raise StandardError unless @event
    data = @event.attachments.select({:event_attachment_id=>params[:event_attachment_id]})[0]
    raise StandardError unless data
    file = data.data
    response.headers['Content-Disposition'] = "attachment; filename=\"#{file.filename}\""
    response.headers['Content-Type'] = data.mime_type
    response.headers['Content-Length'] = data.filesize
#    response.headers['Last-Modified'] = file.last_modified
    render(:text=>file.data)
   rescue
    render(:text=>"File not found",:status=>404)
  end

  def track_event
    @track = @conference.tracks({:conference_track=>params[:track]})[0]
    raise StandardError unless @track
    @event = @conference.events({:conference_track=>params[:track],:translated=>@current_language,:event_id=>params[:id]})[0]
    raise StandardError unless @event
    @events = @conference.events({:conference_track=>params[:track],:translated=>@current_language})
    @content_title = @event.title
    render(:action=>:event)
  end

  def events
    @events = @conference.events({:translated=>@current_language},{:order=>[:title,:subtitle]})
  end

  def track_events
    @track = @conference.tracks({:conference_track=>params[:track]})[0]
    raise StandardError unless @track
    @events = @conference.events({:conference_track=>params[:track],:translated=>@current_language})
    render(:action=>:events)
  end

  def speaker
    @speaker = @conference.persons({:person_id=>params[:id]},{:order=>[:name]})[0]
    raise StandardError unless @speaker
    @speakers = @conference.persons({},{:order=>[:name]})
    @content_title = @speaker.name
  end

  def speakers
    @speakers = @conference.persons({},{:order=>[:name]})
    @content_title = local(:speakers)
  end

  protected

  def init
    if params[:preview]
      # if preview is specified we work on live data
      @conference = Release_preview::Conference.select_single({:conference_id=>params[:conference_id]})
    elsif params[:release]
      # if a specific release is selected we show that one
      @conference = Release::Conference.select_single({:conference_id=>params[:conference_id],:conference_release_id=>params[:release]})
    else
      # otherwise we show the latest release with fallback to live data if nothing has been released yet
      begin
        @conference = Release::Conference.select_single({:conference_id=>params[:conference_id]},{:limit=>1,:order=>Momomoto.desc(:conference_release_id)})
      rescue Momomoto::Nothing_found
        @conference = Release_preview::Conference.select_single({:conference_id=>params[:conference_id]})
      end
    end
    @current_language = params[:language] || 'en'
  end

  def check_permission
    POPE.conference_permission?('pentabarf::login', params[:conference_id]) &&
    POPE.conference_permission?('conference::show', params[:conference_id])
  end

end
