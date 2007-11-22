
require 'RMagick'

class ImageController < ApplicationController

  before_filter :modified_since, :only=>[:conference,:event,:person]

  [:conference, :event, :person].each do | action |
    define_method( action ) do
      begin
        img = "#{action.to_s.capitalize}_image".constantize.select_single({"#{action}_id".to_sym=>params[:id].to_i})
        data = img.image
        mimetype = img.mime_type
      rescue
        img = File.join( RAILS_ROOT, "public/images/icon-#{action}-128x128.png" )
        data = File.open( img ).read
        mimetype = 'image/png'
      end
      resolution = params[:size]
      response.headers['Content-Type'] = mimetype
      response.headers['Last-Modified'] = @timestamp
      if mimetype == "image/svg+xml"
        render( :text => data )
      else
        render( :text => resize( data, resolution ))
      end
    end
  end

  protected

  def check_permission
    if POPE.permission?('pentabarf_login')
      return true
    elsif POPE.permission?('submission_login')
      case params[:action]
        when 'event'
          return true if POPE.own_events.member?(params[:id].to_i)
        when 'person'
          return true if POPE.user.person_id == params[:id].to_i
        when 'conference'
          return true if Conference.select(:conference_id=>params[:id].to_i,:f_submission_enabled=>'t').length == 1
      end
    end
    false
  end

  def modified_since
    action = params[:action]
    klass = "View_#{action}_image_modification".constantize
    modification = klass.select({"#{action}_id"=>params[:id].to_i}, {:limit=>1} ).first
    if modification
      @timestamp = modification.last_modified
    else
      file = File.join( RAILS_ROOT, "public/images/icon-#{action}-128x128.png" )
      @timestamp = File.mtime( file ).to_s
    end
    if request.env['HTTP_IF_MODIFIED_SINCE'] && request.env['HTTP_IF_MODIFIED_SINCE'] == @timestamp
      render({:text => "Not changed",:status => 304})
      return false
    end
    true
  end

  def resize( data, resolution)
    return data if not resolution
    height, width = resolution.split('x')
    image = Magick::Image.from_blob( data )[0]
    image.x_resolution = 72
    image.y_resolution = 72
    format = nil
    image.resize!( height.to_i, width.to_i ).strip!.to_blob
   rescue
    data
  end


end
