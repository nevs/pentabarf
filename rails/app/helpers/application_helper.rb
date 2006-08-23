# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def version()
    "0.3"
  end

  def local( text )
    h("<[#{text}]>")
  end

  def select_tag( name, collection, options = {}, html_options = {} )
    xml = Builder::XmlMarkup.new(:indent=>1)
    html_options[:name] = name
    html_options[:id] = name
    html_options[:tabindex] = 0 if not html_options[:tabindex]
    xml.select( html_options ) do
      collection.each do | element |
        value = options.has_key?(:value) ? element.send( options[:value] ) : element
        key = options.has_key?(:key) ? element.send( options[:key] ) : element
        xml.option( value, { :value=> key })
      end
    end
  end

end

