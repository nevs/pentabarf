class ImageController < ApplicationController

  [:conference, :event, :person].each do | o |
    define_method( o ) do
      render(:text=>'')
    end
  end

end
