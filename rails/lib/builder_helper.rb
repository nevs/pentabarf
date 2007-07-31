
module Builder_helper

  def hidden_field( row, column )
    xml = Builder::XmlMarkup.new
    name = "#{row.class.table.table_name}[#{column}]"
    xml.input({:type=>:hidden, :id=>name, :name => name, :value => row[column]})
  end

  def text_field_row( row, column, options = {}, &block )
    options[:size] = 40 unless options[:size]
    table = row.class.table.table_name
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( "table::#{table}::#{column}") ) end
      xml.td do
        options[:id] = options[:name] = "#{table}[#{column}]"
        options[:value] = row[column]
        options[:tabindex] = 0
        xml.input( options )
        yield( xml ) if block_given?
      end
    end
  end

  def check_box_row( row, column, options = {}, &block )
    table = row.class.table.table_name
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( "table::#{table}::#{column}" ) ) end
      xml.td do
        options[:id] = options[:name] = "#{table}[#{column}]"
        options[:tabindex] = 0
        options[:type] = :checkbox
        options[:value] ||= 't'
        options[:checked] = :checked if row[column]
        xml.input( options )
      end
    end
  end

  def text_area_fieldset( row, column, options = {} )
    table = row.class.table.table_name
    xml = Builder::XmlMarkup.new
    xml.fieldset do
      xml.legend( local( "table::#{table}::#{column}") )
      options[:id] = options[:name] = "#{table}[#{column}]"
      options[:tabindex] = 0
      xml.textarea( row[column], options )
    end
  end

  def select_tag( name, collection, options = {} )
    xml = Builder::XmlMarkup.new
    o = options.dup
    o[:name] = o[:id] = name
    o[:tabindex] = 0 if not options[:tabindex]
    o[:onchange] = "master_change(this,'#{options[:master]}');" if options[:master]
    found_selected = false
    o.delete(:selected)
    xml.select( o ) do
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
        if key == options[:selected]
          opts[:selected] = 'selected'
          found_selected = true
        end
        opts[:value] = key
        opts[:class] = element[1] if options[:slave]
        xml.option( value, opts )
      end
      if options[:selected] && !found_selected
        xml.option( options[:selected], {:value=>options[:selected],:selected=>:selected})
      end
    end
  end

  def select_row( row, column, collection, options = {} )
    name = "#{row.class.table.table_name}[#{column}]"
    options[:selected] = row.send(column) unless options[:selected]
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( "table::#{row.class.table.table_name}::#{column}" ) ) end
      xml.td do xml << select_tag( name, collection, options ) end
    end
  end

  def radio_row( row, column, collection, options = {} )
    name = "#{row.class.table.table_name}[#{column}]"
    options[:checked] = row.send(column) unless options[:checked]
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( local( "table::#{row.class.table.table_name}::#{column}" ) ) end
      collection.each do | element |
        if element.instance_of?( Array )
          key = element.first
        else
          key = element
        end
        opts = {:type=>:radio,:name=>name,:value=>key}
        opts[:checked] = :checked if options[:checked] == key
        xml.td do xml.input( opts ) end
      end
    end
  end

  def money_currency_row( row, sum_column, currency_column, options = {} )
    name = "#{row.class.table.table_name}[#{currency_column}]"
    xml = Builder::XmlMarkup.new
    xml << text_field_row( row, sum_column, {:size=>10} ) do | x |
      x << select_tag( name, Currency.select.map{|e| [e.currency_id, e.iso_4217_code]}, {:selected=>@person_travel.send(currency_column)})
    end
  end

  def date_button_row( row, column, options = {} )
    xml = Builder::XmlMarkup.new
    name = "#{row.class.table.table_name}[#{column}]"
    button_id = "#{row.class.table.table_name}_#{column}"
    xml << text_field_row( row, column, {:size => 12 } ) do | x |
      x.button( '...', {:type=>:button,:id=>button_id})
      x.script( "Calendar.setup({inputField:'#{name}', ifFormat:'%Y-%m-%d', button:'#{button_id}', showOthers:true, singleClick:false});", {:type=>'text/javascript'})
    end
  end

  def file_row( table, column )
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label local( "table::#{table}::#{column}" ) end
      xml.td do
        xml << file_field_tag( "#{table}[#{column}]", {:tabindex => 0, :onchange => "enable_save_button()"})
      end
    end
  end

end

