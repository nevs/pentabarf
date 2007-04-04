
module Builder_helper

  def select_tag( name, collection, options = {}, html_options = {} )
    xml = Builder::XmlMarkup.new
    html_options[:name] = name
    html_options[:id] = name
    html_options[:tabindex] = 0 if not html_options[:tabindex]
    xml.select( html_options ) do
      if options[:with_empty]
        opts = {}
        opts[:selected] = :selected if options[:selected] == nil
        xml.option( '', opts )
      end
      collection.each do | element |
        opts = {}
        value = options.has_key?(:value) ? element.send( options[:value] ) : element
        key = options.has_key?(:key) ? element.send( options[:key] ) : element
        opts[:selected] = 'selected' if key == options[:selected]
        opts[:value] = key
        opts[:class] = "#{options[:class]}_#{element.send(options[:class])}" if options[:class]
        xml.option( value, opts )
      end
    end
  end

end
