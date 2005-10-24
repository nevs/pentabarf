require 'RMagick'

class ImageController < ApplicationController
  before_filter :authorize 
  before_filter :modified_since, :except => [:events_per_track, :events_per_language, :speaker_per_gender]

  def conference
    image = Momomoto::View_conference_image.find( {:conference_id => extract_id( params[:id] ) } )
    if image.length == 1
      deliver_image( image, params[:id] )
    else
      deliver_static_image( RAILS_ROOT + '/public/images/icon-conference-128x128.png', params[:id])
    end
    GC.start
  end

  def event
    image = Momomoto::View_event_image.find( {:event_id => extract_id( params[:id] ) } )
    if image.length == 1
      deliver_image( image, params[:id] )
    else
      deliver_static_image( RAILS_ROOT + '/public/images/icon-event-128x128.png', params[:id])
    end
    GC.start
  end

  def person
    image = Momomoto::View_person_image.find( {:person_id => extract_id( params[:id] ) } )
    if image.length == 1
      deliver_image( image, params[:id] )
    else
      deliver_static_image( RAILS_ROOT + '/public/images/icon-person-128x128.png', params[:id])
    end
    GC.start
  end

  def events_per_track
    @current_language_id = @user.preferences[:current_language_id]
    params[:id] = params[:id].to_s.gsub(/\..*$/, '')
    tracks = Momomoto::View_conference_track.find({:conference_id=>params[:id],:language_id=>@current_language_id})
    events = Momomoto::View_event.find({:conference_id=>params[:id],:translated_id=>@current_language_id,:event_state_tag=>'accepted'})
    track_events = []
    tracks.each do | track | track_events[track.conference_track_id] = 0 end
    track_events[0] = 0
    events.each do | e | track_events[e.conference_track_id || 0] += 1 end
    pieces = []
    tracks.each do | t |
      pieces.push({:name => t.name, :angle => ( track_events[t.conference_track_id] * 2 * Math::PI / events.length )})
    end
    pieces.sort! do | a, b | b[:angle] <=> a[:angle] end
    render_pie(pieces)
  end

  def events_per_language
    @current_language_id = @user.preferences[:current_language_id]
    params[:id] = params[:id].to_s.gsub(/\..*$/, '')
    langs = Momomoto::View_conference_language.find({:conference_id=>params[:id],:translated_id=>@current_language_id})
    events = Momomoto::View_event.find({:conference_id=>params[:id],:translated_id=>@current_language_id,:event_state_tag=>'accepted'})
    lang_events = []
    langs.each do | l | lang_events[l.language_id] = 0 end
    lang_events[0] = 0
    events.each do | e | lang_events[e.language_id || 0] += 1 end
    pieces = []
    langs.each do | l |
      pieces.push({:name => l.name, :angle => ( lang_events[l.language_id] * 2 * Math::PI / events.length )})
    end
    pieces.sort! do | a, b | b[:angle] <=> a[:angle] end
    render_pie(pieces)
  end

  def speaker_per_gender
    speaker = Momomoto::View_report_schedule_gender.find({:conference_id=>params[:id].to_s.gsub(/\..*$/, '')})
    speaker_gender = {}
    speaker_gender['t'], speaker_gender['f'] = 0,0
    speaker.each do | s | 
      next unless s.gender
      speaker_gender[s.gender] += 1
    end
    pieces = []
    pieces.push({:name=>'male',:angle=>((speaker_gender['t'].to_f * 2.0 * Math::PI)/speaker.length.to_f)})
    pieces.push({:name=>'female',:angle=>((speaker_gender['f'].to_f * 2.0 * Math::PI)/speaker.length.to_f)})
    render_pie(pieces)
  end

  protected

  def render_pie( pieces, radius = 75 )
    colors = ['cornflowerblue', 'lime', 'orangered', 'yellow', 'lightseagreen', 'mediumorchid']
    pieces.each_with_index do | p, index |
      p[:color] = colors[ index % colors.length ]
    end
    canvas = Magick::Image.new( radius * 3.5 , radius * 2.1 )
    gc = Magick::Draw.new
    gc.stroke('black')
    gc.stroke_width(1)
    offset = 0
    pieces.each do | p |
      next if p[:angle] == 0.0
      x0 = radius+(Math.sin(offset) * radius)
      y0 = radius-(Math.cos(offset) * radius)
      x1 = radius+(Math.sin(offset + p[:angle]) * radius)
      y1 = radius-(Math.cos(offset + p[:angle]) * radius)
      gc.fill(p[:color])
      gc.path("M#{radius},#{radius} L#{x0},#{y0} A#{radius},#{radius} 0 #{p[:angle] > Math::PI ? '1' : '0'}, 1 #{x1},#{y1} z")
      offset += p[:angle]
    end
    line = 15
    gc.stroke('black')
    gc.pointsize(14)
    pieces.each do | p |
      gc.text_undercolor(p[:color])
      gc.text( radius * 2 + 10, line, sprintf( ' %s %50s', p[:name], ' '))
      line += 18
    end
    
    gc.draw(canvas)
    canvas.format = 'PNG'
    @response.headers['Content-Type'] = 'image/png'
    render_text(canvas.to_blob)
  end

  def modified_since
    if action_name == 'conference'
      modification = Momomoto::View_conference_image_modification.find( {:conference_id => extract_id( @params[:id] )} )
      if modification.length == 1
        @timestamp = modification.last_changed
      else
        @timestamp = File.ctime( RAILS_ROOT + '/public/images/icon-conference-128x128.png' )
      end
    elsif action_name == 'event'
      modification = Momomoto::View_event_image_modification.find( {:event_id => extract_id( @params[:id] )} )
      if modification.length == 1
        @timestamp = modification.last_changed
      else
        @timestamp = File.ctime( RAILS_ROOT + '/public/images/icon-event-128x128.png' )
      end
    elsif action_name == 'person'
      modification = Momomoto::View_person_image_modification.find( {:person_id => extract_id( @params[:id] )} )
      if modification.length == 1
        @timestamp = modification.last_changed
      else
        @timestamp = File.ctime( RAILS_ROOT + '/public/images/icon-person-128x128.png' )
      end
    end
    if @request.env['HTTP_IF_MODIFIED_SINCE'] == @timestamp
      render_text( "Not changed", 304 )
      return false
    end
    true
  end

  def deliver_image( image, query )
    @response.headers['Content-Type'] = image.mime_type
    @response.headers['Last-Modified'] = @timestamp
    # render_text(image.image)
    render_resized( Magick::Image.from_blob( image.image )[0], query )
  end

  def deliver_static_image( image, query )
    image_file = File.open( image )
    @response.headers['Content-Type'] = 'image/png'
    @response.headers['Last-Modified'] = @timestamp
    render_resized( Magick::Image.from_blob( image_file.read )[0], query )
  end

  def render_resized( image, query)
    image.x_resolution = 72
    image.y_resolution = 72
    if query.match( /^\d+-(\d+)x(\d+)/ ) || query.match( /^new-(\d+)x(\d+)/ )
      height = $1.to_i > 512 ? 32 : $1.to_i
      width = $2.to_i > 512 ? 32 : $2.to_i
    else
      height = 32
      width = 32
    end
    render_text( image.resize!( height, width ).strip!.to_blob )
  end

  def extract_id( query )
    query.gsub( /[.-].*/, '')
  end

end
