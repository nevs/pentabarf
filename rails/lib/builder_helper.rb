
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

  def hidden_field( row, column )
    xml = Builder::XmlMarkup.new
    name = "#{row.class.table.table_name}[#{column}]"
    xml.input({:type=>:hidden, :id=>name, :name => name, :value => row[column]})
  end

  def text_field_row( row, column, options = {}, &block )
    options[:size] = 40 unless options[:size]
    __text_field_row( "#{column}", "#{row.class.table.table_name}[#{column}]", row[column], options, &block )
  end

  def __text_field_row( label, name, value = '', options = {} )
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( label ) ) end
      xml.td do
        options[:id] = options[:name] = name
        options[:value] = value
        options[:tabindex] = 0
        xml.input( options )
        yield( xml ) if block_given?
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

end

