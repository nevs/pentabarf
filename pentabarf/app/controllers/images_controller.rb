require 'RMagick'

class ImagesController < ApplicationController
  before_filter :authorize, :modified_since

  def conference
    image = Momomoto::View_conference_image.find( {:conference_id => extract_id( params[:id] ) } )
    if image.length == 1
      deliver_image( image, params[:id] )
    else
      render_text("Not found.", 404)
    end
  end

  def event
    image = Momomoto::View_event_image.find( {:event_id => extract_id( params[:id] ) } )
    if image.length == 1
      deliver_image( image, params[:id] )
    else
      render_text("Not found.", 404)
    end
  end

  def person
    image = Momomoto::View_person_image.find( {:person_id => extract_id( params[:id] ) } )
    if image.length == 1
      deliver_image( image, params[:id] )
    else
      render_text("Not found.", 404)
    end
  end

  protected

  def modified_since
    @modification = nil
    if action_name == 'conference'
      @modification = Momomoto::View_conference_image_modification.find( {:conference_id => extract_id( @params[:id] )} )
    elsif action_name == 'event'
      @modification = Momomoto::View_event_image_modification.find( {:event_id => extract_id( @params[:id] )} )
    elsif action_name == 'person'
      @modification = Momomoto::View_person_image_modification.find( {:person_id => extract_id( @params[:id] )} )
    end
    if @modification && @modification.length == 1 && @request.env['HTTP_IF_MODIFIED_SINCE'] == @modification.last_changed
      render_text( "Not changed", 304 )
      return false
    end
    true
  end

  def deliver_image( image, query )
    @response.headers['Content-type'] = image.mime_type
    @response.headers['Last-Modified'] = @modification.last_changed
    img = Magick::Image.from_blob( image.image )[0]
    img.x_resolution = 72
    img.y_resolution = 72
    if query.match( /\d+-(\d+)x(\d+)/ )
      height = $1.to_i > 512 ? 32 : $1.to_i
      width = $2.to_i > 512 ? 32 : $2.to_i
    else
      height = 32
      width = 32
    end
    render_text( img.resize!( height, width ).strip!.to_blob )
  end

  def extract_id( query )
    query.gsub( /[.-].*/, '')
  end

end
