
class HTMLExport
  @urls = []
  @urls_done = []
  class << self

    attr_accessor :conference, :urls, :urls_done, :http_prefix, :file_prefix, :session

    def init( conf )
      @conference = conf
      @session = ActionController::Integration::Session.new
      @session.host = 'pentabarf.org'
      @http_prefix = '/'
      @file_prefix = "tmp/html-export/#{conf.acronym}/"
      get('/')
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
      @urls << url if not @urls_done.member?( target )
      target
    end

    def make_url( url, prefix )
      url[:controller] ||= 'schedule'
      url[:language] ||= 'en'
      target = case url[:controller]
        when 'file' then
          case url[:action]
            when :event_attachment then "#{prefix}attachments/#{url[:id]}#{url[:filename].to_s.length > 0 ? '_' + url[:filename] : ''}"
          end
        when 'schedule' then
          case url[:action]
            when :index then "#{prefix}index.#{url[:language]}.html"
            when :day then "#{prefix}day_#{url[:id]}.#{url[:language]}.html"
            when :event then "#{prefix}events/#{url[:id]}.#{url[:language]}.html"
            when :events then "#{prefix}events.#{url[:language]}.html"
            when :track_event then "#{prefix}track/#{url[:track]}/#{url[:id]}.#{url[:language]}.html"
            when :track_events then "#{prefix}track/#{url[:track]}/index.#{url[:language]}.html"
            when :speaker then "#{prefix}speakers/#{url[:id]}.#{url[:language]}.html"
            when :speakers then "#{prefix}speakers.#{url[:language]}.html"
            when :css then "#{prefix}/style.css"
          end
        when 'image' then
          case url[:action]
            when :conference then "#{prefix}images/conference-128x128.png"
            when :event then "#{prefix}images/event-128x128.png"
            when :person then "#{prefix}images/person-128x128.png"
          end
        when 'xcal' then "#{prefix}schedule.#{url[:language]}.xcs"
        when 'ical' then "#{prefix}schedule.#{url[:language]}.ics"
        when 'xml' then "#{prefix}schedule.#{url[:language]}.xml"
      end
      puts "Empty target for #{url.inspect}" if not target
      target
    end

    def url_for_file( url )
      make_url( url, @file_prefix )
    end

    def url_for_http( url)
      make_url( url, @http_prefix )
    end

    def export( url )
      url[:only_path] = true
      http_url = url_for_http( url )
      return if @urls_done.member?( http_url )
      @urls_done << http_url
      get_hash( url )
      f = File.new( url_for_file( url ), File::CREAT | File::WRONLY | File::TRUNC )
      f.write( HTMLExport.session.response.body )
      f.close
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

