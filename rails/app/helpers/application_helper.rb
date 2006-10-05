# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def version()
    "0.3"
  end

  def local( text )
    "<[#{text.split('::').last}]>"
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

  def js_tabs( tabs )
    xml = Builder::XmlMarkup.new
    xml.div( :id => 'tabs' ) do
      tabs.each do | tab |
        xml.span( tab.to_s, {:id=>"tab-#{tab}",:onclick=>"switch_tab('#{tab}')",:class=>'tab inactive'} )
      end
    end
  end

  # this is meant as complement to the h function which escapes html
  def js( text )
    text.to_s.gsub(/[<>]/, '').gsub( '\\', '\0\0' ).gsub(/\r\n|\n|\r/, "\\n").gsub(/["']/, '\\\\\0')
  end

  def js_function( name, *parameter )
    parameter.map! do | p | "'#{js(p.to_s)}'" end
    "#{name}(#{parameter.join(',')});"
  end

  def event_table( events )
    xml = Builder::XmlMarkup.new
    xml.table do
      xml.thead do
        xml.tr do
          xml.th( local( 'table::event::title' ) )
          xml.th( local( 'table::event::subtitle' ) )
        end
      end
      xml.tbody do
        fields = [:title,:subtitle]
        events.each do | e |
          xml.tr do
            fields.each do | field_name |
              xml.td do
                xml.a( e.send( field_name ), {:href=>url_for(:controller=>'pentabarf',:action=>:event,:id=>e.event_id)})
              end
            end
          end
        end
      end
    end
  end

  def person_table( persons )
    xml = Builder::XmlMarkup.new
    xml.table do
      xml.thead do
        xml.tr do
          xml.th( local( 'table::person::first_name' ) )
          xml.th( local( 'table::person::last_name' ) )
          xml.th( local( 'table::person::nickname' ) )
          xml.th( local( 'table::person::public_name' ) )
        end
      end
      xml.tbody do
        fields = [:first_name,:last_name,:nickname,:public_name]
        persons.each do | p |
          xml.tr do
            fields.each do | field_name |
              xml.td do
                xml.a( p.send( field_name ), {:href=>url_for(:controller=>'pentabarf',:action=>:person,:id=>p.person_id)})
              end
            end
          end
        end
      end
    end
  end

  def conference_table( conferences )
    xml = Builder::XmlMarkup.new
    xml.table do
      xml.thead do
        xml.tr do
          xml.th( local( 'table::conference::title' ) )
          xml.th( local( 'table::conference::subtitle' ) )
        end
      end
      xml.tbody do
        fields = [:title,:subtitle]
        conferences.each do | c |
          xml.tr do
            fields.each do | field_name |
              xml.td do
                xml.a( c.send( field_name ), {:href=>url_for(:controller=>'pentabarf',:action=>:conference,:id=>c.conference_id)})
              end
            end
          end
        end
      end
    end
  end

end

