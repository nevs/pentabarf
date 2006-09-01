# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def version()
    "0.3"
  end

  def local( text )
    "<[#{text}]>"
  end

  def text_field_row( label, name, value = '', options = {} )
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( label ) ) end
      xml.td do
        options[:id] = options[:name] = name
        options[:value] = value
        options[:tabindex] = 0
        xml.input( options )
      end
    end
  end

  def check_box_row( label, name, checked = false, options = {} )
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( label ) ) end
      xml.td do
        options[:id] = options[:name] = name
        options[:tabindex] = 0
        options[:type] = :checkbox
        options[:value] ||= 't'
        options[:checked] = :checked if checked
        xml.input( options )
      end
    end
  end

  def text_area_row( label, name, value = '', options = {} )
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( label ) ) end
      xml.td do
        options[:id] = options[:name] = name
        options[:tabindex] = 0
        xml.textarea( value, options )
      end
    end
  end

  def text_area_fieldset( label, name, value = '', options = {} )
    xml = Builder::XmlMarkup.new
    xml.fieldset do
      xml.legend( local( label ) )
      options[:id] = options[:name] = name
      options[:tabindex] = 0
      xml.textarea( value, options )
    end
  end

  def select_row( label, name, collection = [], options = {}, html_options = {} )
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( label ) ) end
      xml.td do
        xml << select_tag( name, collection, options, html_options )
      end
    end
  end

  def select_tag( name, collection, options = {}, html_options = {} )
    xml = Builder::XmlMarkup.new(:indent=>1)
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
        xml.option( value, opts )
      end
    end
  end

end

