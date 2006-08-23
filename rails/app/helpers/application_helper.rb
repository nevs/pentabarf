# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def version()
    "0.3"
  end

  def local( text )
    h("<[#{text}]>")
  end

  def select_tag( name, collection, options, html_options )
    xml = Builder::XmlMarkup.new(:indent=>1) 
    html_options[:name] = name
    html_options[:id] = name
    xml.select( html_options ) do
      collection.each do | element |
        xml.option( element.send( options[:value] ), {:value=>element.send( options[:key] )})
      end
    end
  end

end

