require 'icalendar'

class IcalController < ApplicationController

  before_filter :init

  def conference
    conf = Conference.select_single({:conference_id=>params[:id]})
    tz = Timezone.select_single({:timezone => conf.timezone})
    lang = Language.select_single({:language=>@current_language})
    rooms = Conference_room.select({:conference_id=>conf.conference_id})
    events = View_schedule_simple.select({:conference_id=>conf.conference_id})

    cal = Icalendar::Calendar.new
    cal.prodid "-//Pentabarf//Schedule//#{lang.language.upcase}"

    # XXX remove hardcoded daylight saving time difference
    cal.timezone do | t |
      tzid tz.timezone
      standard = Icalendar::Standard.new
      standard.dtstart '19671029T020000'
      standard.add_recurrence_rule 'FREQ=YEARLY;BYDAY=-1SU;BYMONTH=10'
      standard.tzoffsetfrom( (tz.utc_offset + 3600).strftime('%H%M') )
      standard.tzoffsetto tz.utc_offset.strftime('%H%M')
      standard.tzname tz.abbreviation
      daylight = Icalendar::Daylight.new
      standard.dtstart '19870405T020000'
      standard.add_recurrence_rule 'FREQ=YEARLY;BYDAY=1SU;BYMONTH=4'
      standard.tzoffsetfrom tz.utc_offset.strftime('%H%M')
      standard.tzoffsetto( (tz.utc_offset + 3600).strftime('%H%M') )
      add_component( standard )
      add_component( daylight )
    end

    events.each do | event |
      cal.event do
        uid "#{event.event_id}@#{conf.acronym}@pentabarf.org"
#        dtstamp (event.start_date - tz.utc_offset.to_i ).strftime('%Y%m%dT%H%M%S')
        dtstamp Time.now.strftime('%Y%m%dT%H%M%S')
        dtstart event.start_date.strftime('%Y%m%dT%H%M%S'), {'TZID'=>tz.timezone}
        dtend event.end_date.strftime('%Y%m%dT%H%M%S'), {'TZID'=>tz.timezone}
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

end

