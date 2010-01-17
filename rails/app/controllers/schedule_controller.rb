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

  def events
    @events = @conference.events({:translated=>@current_language},{:order=>[:title,:subtitle]})
    @content_title = local('schedule::events')
  end

  def speaker
    @speaker = @conference.persons({:person_id=>params[:id]},{:order=>[:name]})[0]
    raise StandardError unless @speaker
    @speakers = @conference.persons({},{:order=>[:name]})
    @content_title = @speaker.name
  end

  def speakers
    @speakers = @conference.persons({},{:order=>[:name]})
    @content_title = local('schedule::speakers')
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

  def track_events
    @track = @conference.tracks({:conference_track=>params[:track]})[0]
    raise StandardError unless @track
    @events = @conference.events({:conference_track=>params[:track],:translated=>@current_language})
    @content_title = local('schedule::events')
    render(:action=>:events)
  end

  protected

  def init
    if params[:preview]
      # if preview is specified we work on live data
      @conference = Release_preview::Conference.select_single({:acronym=>params[:conference]})
    elsif params[:release]
      # if a specific release is selected we show that one
      @conference = Release::Conference.select_single({:acronym=>params[:conference],:conference_release_id=>params[:release]})
    else
      # otherwise we show the latest release with fallback to live data if nothing has been released yet
      begin
        @conference = Release::Conference.select_single({:acronym=>params[:conference]},{:limit=>1,:order=>Momomoto.desc(:conference_release_id)})
      rescue Momomoto::Nothing_found
        @conference = Release_preview::Conference.select_single({:acronym=>params[:conference]})
      end
    end
    @current_language = params[:language] || 'en'
  end

end
