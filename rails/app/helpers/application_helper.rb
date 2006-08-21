# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def version()
    "0.3"
  end

  def local( text )
    h("<[#{text}]>")
  end

end
