class ImageController < ApplicationController

  [:conference, :event, :person].each do | o |
    define_method( action ) do
      img = File.join( RAILS_ROOT, "public/images/icon-#{action}-128x128.png" ).read

      response.headers['Content-Type'] = 'image/png'
      render( :text => img )
    end
  end

end
