
module Builder_helper

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

  def check_box_row( row, column, options = {}, &block )
    __check_box_row( "#{column}", "#{row.class.table.table_name}[#{column}]", row[column], options, &block )
  end

  def __check_box_row( label, name, checked = false, options = {} )
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

  def select_tag( name, collection, options = {} )
    xml = Builder::XmlMarkup.new
    options[:name] = options[:id] = name
    options[:tabindex] = 0 if not options[:tabindex]
    xml.select( options ) do
      if options[:with_empty]
        opts = {}
        opts[:selected] = :selected if options[:selected] == nil
        xml.option( '', opts )
        options.delete(:with_empty)
      end
      collection.each do | element |
        opts = {}
        if element.instance_of?( Array )
          key, value = element.first, element.last
        else
          key = value = element
        end
        opts[:selected] = 'selected' if key == options[:selected]
        opts[:value] = key
        xml.option( value, opts )
      end
    end
  end

  def select_row( row, column, collection, options = {} )
    name = "#{row.class.table.table_name}[#{column}]"
    options[:selected] = row.send(column) unless options[:selected]
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( column ) ) end
      xml.td do xml << select_tag( name, collection, options ) end
    end
  end

  def __select_row( label, name, collection = [], options = {}, html_options = {} )
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( label ) ) end
      xml.td do
        xml << select_tag( name, collection, options, html_options )
      end
    end
  end

  def date_button_row( row, column, options = {}, &block )
    xml = Builder::XmlMarkup.new
    name = "#{row.class.table.table_name}[#{column}]"
    button_id = "#{row.class.table.table_name}_#{column}"
    xml << text_field_row( row, column, {:size => 12 } ) do | x |
      x.button( '...', {:type=>:button,:id=>button_id})
      x.script( "Calendar.setup({inputField:'#{name}', ifFormat:'%Y-%m-%d', button:'#{button_id}', showOthers:true, singleClick:false});", {:type=>'text/javascript'})
    end
  end

end

