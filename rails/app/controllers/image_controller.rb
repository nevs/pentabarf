class ImageController < ApplicationController

  [:conference, :event, :person].each do | action |
    define_method( action ) do
      begin
        img = const_get("View_#{action}_image").select({"#{action}_id".to_sym=>params[:id]})
        data = img.image
        mimetype = img.mime_type
      rescue
        img = File.join( RAILS_ROOT, "public/images/icon-#{action}-128x128.png" )
        data = File.open( img ).read
        mimetype = 'image/png'
      end

      response.headers['Content-Type'] = mimetype
      render( :text => data )
    end
  end

end
