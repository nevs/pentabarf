require 'icalendar'

class IcalController < ApplicationController

  before_filter :init

  def conference
    begin
      conf = Release::Conference.select_single({:acronym=>params[:conference]},{:limit=>1,:order=>Momomoto.desc(:conference_release_id)})
    rescue Momomoto::Nothing_found
      conf = Release_preview::Conference.select_single({:acronym=>params[:conference]})
    end
    tz = Timezone.select_single({:timezone => conf.timezone})
    lang = Language.select_single({:language=>@current_language})
    rooms = conf.rooms

    cal = Icalendar::Calendar.new
    cal.prodid "-//Pentabarf//Schedule//#{lang.language.upcase}"

    # XXX remove hardcoded daylight saving time difference
    # XXX recurrence rules commented out to make it import into google calendar
    cal.timezone do | t |
      tzid tz.timezone
      standard = Icalendar::Standard.new
      standard.dtstart '19671029T020000'
#      standard.add_recurrence_rule 'FREQ=YEARLY;BYDAY=-1SU;BYMONTH=10'
      standard.tzoffsetfrom( (tz.utc_offset + 3600).strftime('%H%M') )
      standard.tzoffsetto tz.utc_offset.strftime('%H%M')
      standard.tzname tz.abbreviation
      daylight = Icalendar::Daylight.new
      standard.dtstart '19870405T020000'
#      standard.add_recurrence_rule 'FREQ=YEARLY;BYDAY=1SU;BYMONTH=4'
      standard.tzoffsetfrom tz.utc_offset.strftime('+%H%M')
      standard.tzoffsetto( (tz.utc_offset + 3600).strftime('+%H%M') )
      add_component( standard )
      add_component( daylight )
    end

    conf.events(:translated=>@current_language).each do | event |
      cal.event do
        uid "#{event.event_id}@#{conf.acronym}@pentabarf.org"
#        dtstamp (event.start_datetime - tz.utc_offset.to_i ).strftime('%Y%m%dT%H%M%S')
        dtstamp Time.now.strftime('%Y%m%dT%H%M%S')
        dtstart event.start_datetime.strftime('%Y%m%dT%H%M%S'), {'TZID'=>tz.timezone}
        dtend event.end_datetime.strftime('%Y%m%dT%H%M%S'), {'TZID'=>tz.timezone}
        duration sprintf( 'PT%dH%02dM', event.duration.hour, event.duration.min )
        summary event.title + ( event.subtitle ? " - #{event.subtitle}" : '')
        description event.abstract.to_s.gsub( "\n", '' ).gsub( "\r", '' )
        add_category "Lecture"
        status "CONFIRMED"
        url "#{conf.export_base_url}events/#{event.event_id}.#{lang.language}.html"
        location event.conference_room
      end
    end
    render(:text=>cal.to_ical)
  end

  protected

  def init
    @current_language = 'en'
    response.content_type = Mime::ICS
  end

  def check_permission
    return false if not POPE.conference_permission?('pentabarf::login',params[:conference_id])
    case params[:action]
      when 'conference' then POPE.conference_permission?('conference::show',params[:conference_id])
      else
        false
    end
  end

end

