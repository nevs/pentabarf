require 'RMagick'

class ImageController < ApplicationController
  session(:off)

  def conference
    #image = Momomoto::View_conference_image.find( {:conference_id => extract_id( params[:id] ) } )
    if false
      deliver_image( image, params[:id] )
    else
      deliver_static_image( RAILS_ROOT + '/public/images/icon-conference-128x128.png', params[:id])
    end
    GC.start
  end

  def event
    #image = Momomoto::View_event_image.find( {:event_id => extract_id( params[:id] ) } )
    if false
      deliver_image( image, params[:id] )
    else
      deliver_static_image( RAILS_ROOT + '/public/images/icon-event-128x128.png', params[:id])
    end
    GC.start
  end

  def person
    #image = Momomoto::View_person_image.find( {:person_id => extract_id( params[:id] ) } )
    if false
      deliver_image( image, params[:id] )
    else
      deliver_static_image( RAILS_ROOT + '/public/images/icon-person-128x128.png', params[:id])
    end
    GC.start
  end

  protected

  def modified_since
    if ['conference', 'event', 'person'].member?( action_name )
      modification = Momomoto::View_conference_image_modification.find( {:conference_id => extract_id( @params[:id] )} )
      if modification.length == 1
        @timestamp = modification.last_modified
      else
        @timestamp = File.ctime( RAILS_ROOT + '/public/images/icon-conference-128x128.png' )
      end
      if @request.env['HTTP_IF_MODIFIED_SINCE'] == @timestamp
        render_text( "Not changed.", 304 )
        return false
      end
    end
    true
  end

  def deliver_image( image, query )
    response.headers['Last-Modified'] = @timestamp
    # render_text(image.image)
    render_resized( Magick::Image.from_blob( image.image )[0], query )
  end

  def deliver_static_image( image, query )
    image_file = File.open( image )
    response.headers['Content-Type'] = 'image/png'
    response.headers['Last-Modified'] = @timestamp
    render_resized( Magick::Image.from_blob( image_file.read )[0], query )
  end

  def render_resized( image, query)
    image.x_resolution = 72
    image.y_resolution = 72
    format = nil
    if match = query.match( /^\d+-(\d+)x(\d+)(\.([a-z]+))?/i ) || match = query.match( /^new-(\d+)x(\d+)(\.([a-z]+))?/i )
      height = match[1].to_i > 512 ? 512 : match[1].to_i
      width = match[2].to_i > 512 ? 512 : match[2].to_i
      format = case match[4].to_s.upcase
               when 'JPG', 'JPEG' then 'JPEG'
               when 'PNG' then 'PNG'
               when 'GIF' then 'GIF'
               else nil end
    else
      height = 32
      width = 32
      format = nil
    end
    image.format=format if format
    response.headers['Content-Type'] = "image/#{image.format.downcase}"
    render_text( image.resize!( height, width ).strip!.to_blob )
  end

  def extract_id( query )
    query.gsub( /[.-].*/, '')
  end

end
