
require 'uri'

# render schedule pages to static files
class HTMLExport
  @urls = []
  @urls_done = []
  class << self

    attr_accessor :conference, :urls, :urls_done, :http_prefix, :file_prefix, :session

    def init( conf )
      @conference = conf
      @session = ActionController::Integration::Session.new
      @session.host = 'pentabarf.org'
      export_url = URI.parse( conference.export_base_url )
      @http_prefix = export_url.path || "/"
      @file_prefix = "tmp/html-export/#{conf.acronym}/"
      get( "/schedule/#{@conference.conference_id}")
    end

    def get( url )
      status = @session.get( url )
    end

    def get_hash( url )
      get( url_for_rails( url ) )
      if @session.status != 200
        raise StandardError, "Error in HTML Export while processing #{url.inspect}"
        exit 1
      end
    end

    def url_for_rails( *args )
      @session.controller.url_for_rails( *args )
    end

    def url_for( url )
      target = url_for_http( url )
      if not @urls_done.member?( target )
        @urls << url if not ['feedback'].member?(url[:controller])
      end
      target
    end

    # map actions to urls 
    def make_url( url, prefix )
      url[:controller] ||= 'schedule'
      url[:language] ||= 'en'
      target = case url[:controller]
        when 'event' then
          case url[:action]
            when :attachment then "attachments/#{url[:event_attachment_id]}#{url[:filename].to_s.length > 0 ? '_' + url[:filename] : ''}"
          end
        when 'schedule' then
          case url[:action]
            when :index then "index.#{url[:language]}.html"
            when :day then "day_#{url[:id]}.#{url[:language]}.html"
            when :event then "events/#{url[:id]}.#{url[:language]}.html"
            when :events then "events.#{url[:language]}.html"
            when :track_event then "track/#{url[:track]}/#{url[:id]}.#{url[:language]}.html"
            when :track_events then "track/#{url[:track]}/index.#{url[:language]}.html"
            when :speaker then "speakers/#{url[:id]}.#{url[:language]}.html"
            when :speakers then "speakers.#{url[:language]}.html"
            when :css then 
             "style.css"
          end
        when 'image' then
          case url[:action]
            when :conference then "images/conference-#{url[:size]}.#{url[:extension]}"
            when :event then "images/event-#{url[:id]}-#{url[:size]}.#{url[:extension]}"
            when :person then "images/person-#{url[:id]}-#{url[:size]}.#{url[:extension]}"
          end
        when 'feedback' then
          return "#{@conference.feedback_base_url}feedback/#{url[:conference]}/event/#{url[:id]}.#{url[:language]}.html"
        when 'xcal' then "schedule.#{url[:language]}.xcs"
        when 'ical' then "schedule.#{url[:language]}.ics"
        when 'xml' then "schedule.#{url[:language]}.xml"
      end
      puts "Empty target for #{url.inspect}" if not target

      if prefix == ''
        # use relative URLs when no prefix is supplied
        target = "../"*nesting(@current_url) + target
      else
        target = "#{prefix}#{target}"
      end

      target
    end

    def nesting( url )
      case url[:controller].to_sym
        when :schedule then
          case url[:action].to_sym
            when :index,:day,:events,:speakers,:css then 0 
            when :event,:speaker then 1
            when :track_events,:track_event then 2
          end
        when :image,:event then 1
        when :feedback,:xcal,:ical,:xml then 0
      end
    end

    def url_for_file( url )
      make_url( url, file_prefix )
    end

    def url_for_http( url)
      make_url( url, '' )
    end

    def export( url )
      @current_url = url
      url[:only_path] = true
      http_url = url_for_http( url )
      return if @urls_done.member?( http_url )
      @urls_done << http_url
      get_hash( url )
      f = File.new( url_for_file( url ), File::CREAT | File::WRONLY | File::TRUNC )
      f.write( HTMLExport.session.response.body )
      f.close
      rescue => e
        raise StandardError, "Error while processing #{url.inspect}: #{e}"
    end

    def build_tree
      dirs = %w(/ images track events speakers attachments)
      tracks = Conference_track.select(:conference_id=>conference.conference_id)
      tracks.each do | t |
        dirs << "track/#{t.conference_track}"
      end
      dirs.each do | d |
        begin
          Dir.mkdir( File.join( file_prefix, d ) )
        rescue Errno::EEXIST
        end
      end
    end

  end
end

