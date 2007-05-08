class ImageController < ApplicationController

  [:conference, :event, :person].each do | action |
    define_method( action ) do
      img = File.join( RAILS_ROOT, "public/images/icon-#{action}-128x128.png" )

      response.headers['Content-Type'] = 'image/png'
      render( :text => File.open( img ).read )
    end
  end

end
