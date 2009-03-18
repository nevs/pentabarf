
module Builder_helper

  def hidden_field( row, column )
    xml = Builder::XmlMarkup.new
    name = "#{row.class.table.table_name}[#{column}]"
    xml.input({:type=>:hidden, :id=>name, :name => name, :value => row[column]})
  end

  def text_field_row( row, column, options = {}, &block )
    tag_options = options.clone
    # clean options passed to tag creation
    [:label,:counter,:markup_help].each do | name | tag_options.delete( name ) end

    tag_options[:size] = 40 unless options[:size]
    table = row.class.table.table_name
    label = options[:label] || local("#{table}::#{column}")
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( label ) end
      xml.td do
        tag_options[:id] = tag_options[:name] = "#{table}[#{column}]"
        tag_options[:value] = case row[column]
          when Time then row[column].strftime('%H:%M:%S')
          else row[column]
        end

        tag_options[:tabindex] = 0
        xml.input( tag_options )
        xml << js_character_counter( row, column, options[:counter] ) if options.key?(:counter)
        yield( xml ) if block_given?
      end
    end
  end

  def check_box_row( row, column, options = {}, &block )
    if row.instance_of?( Symbol )
      table = row
    else
      table = row.class.table.table_name
      options[:checked] = :checked if row[column]
    end
    xml = Builder::XmlMarkup.new
    label = options[:label] || local("#{table}::#{column}")
    xml.tr do
      xml.td do xml.label( label ) end
      xml.td do
        options[:id] = options[:name] = "#{table}[#{column}]"
        options[:tabindex] = 0
        options[:type] = :checkbox
        options[:value] ||= 't'
        xml.input( options )
      end
    end
  end

  def text_area_fieldset( row, column, options = {} )
    tag_options = options.clone
    # clean options passed to tag creation
    [:label,:counter,:markup_help].each do | name | tag_options.delete( name ) end

    table = row.class.table.table_name
    xml = Builder::XmlMarkup.new
    label = options[:label] || local("#{table}::#{column}")
    xml.fieldset do
      xml.legend( label )
      tag_options[:id] = tag_options[:name] = "#{table}[#{column}]"
      tag_options[:tabindex] = 0
      xml.textarea( row[column], tag_options )
      xml << markup_syntax_help if options[:markup_help]
      xml << js_character_counter( row, column, options[:counter] ) if options.key?(:counter)
      yield( xml ) if block_given?
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
    label = options[:label] || local("#{row.class.table.table_name}::#{column}")
    options[:selected] = row.send(column) unless options[:selected]
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( label ) end
      xml.td do xml << select_tag( name, collection, options ) end
    end
  end

  def radio_row( row, column, collection, options = {} )
    name = options[:name] || "#{row.class.table.table_name}[#{column}]"
    options[:checked] ||= row.send(column)
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label( options[:label] || local( "#{row.class.table.table_name}::#{column}" ) ) end
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
      x << select_tag( name, Currency.select.map(&:currency), {:selected=>@conference_person_travel.send(currency_column)})
    end
  end

  def date_button_row( row, column, options = {} )
    xml = Builder::XmlMarkup.new
    name = "#{row.class.table.table_name}[#{column}]"
    button_id = "#{row.class.table.table_name}_#{column}"
    options[:size] ||= 12
    xml << text_field_row( row, column, options ) do | x |
      x.button( '...', {:type=>:button,:id=>button_id})
      x.script( "Calendar.setup({inputField:'#{name}',ifFormat:'%Y-%m-%d',button:'#{button_id}',showOthers:true,singleClick:false,onUpdate:enable_save_button});", {:type=>'text/javascript'})
    end
  end

  def file_row( table, column )
    xml = Builder::XmlMarkup.new
    xml.tr do
      xml.td do xml.label local( "#{table}::#{column}" ) end
      xml.td do
        xml << file_field_tag( "#{table}[#{column}]", {:tabindex => 0, :onchange => "enable_save_button()"})
      end
    end
  end

  def custom_field_rows( fields, custom, options={} )
    fields.map{ | field |
      next unless custom.respond_to?(field.field_name)
      custom_field_row( field, custom, options )
    }.join("")
  end

  def custom_field_row( field, custom, options={} )
    case field.field_type
      when "boolean"
        check_box_row( custom, field.field_name, options )
      when "text"
        text_field_row( custom, field.field_name, options )
      when "valuelist"
        klass = "Custom::#{field.table_name.capitalize}_#{field.field_name}_values".constantize
        select_row( custom, field.field_name, klass.select.map{|e| e[field.field_name]}, {:with_empty=>true} )
      when "conference-valuelist"
        klass = "Custom::#{field.table_name.capitalize}_#{field.field_name}_values".constantize
        select_row( custom, field.field_name, klass.select(:conference_id=>@current_conference.conference_id).map{|e| e[field.field_name]}, {:with_empty=>true} )
    end
  end

  # add a link to the markup reference
  def markup_syntax_help
    xml = Builder::XmlMarkup.new
    xml.a "» Markup reference", {:href=>"http://daringfireball.net/projects/markdown/syntax",:style=>"font-size:0.65em;",:target=>"_blank"}
    xml.to_s
  end

  def js_character_counter( row, column, maximal )
    xml = Builder::XmlMarkup.new
    element = "#{row.class.table.table_name}[#{column}]"
    xml.div({:id=>element+"-counter-div"}) do
      xml.span( row[column].to_s.mb_chars.length, {:id=>element+"-counter"})
      xml.text!(" / #{maximal}") if maximal.to_i > 0
      xml.text!(" Characters" )
    end
    xml.script({:type=>'text/javascript'}) do
      xml << "Event.observe( $('#{js(element)}'),'keyup',function( e ){ $('#{js(element)}-counter').innerHTML=Event.element(e).value.length ;});"
    end

    return xml.to_s
  end

end

