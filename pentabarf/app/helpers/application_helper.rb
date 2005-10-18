# The methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def select_tag( name, collection, key, value, selected, options = {}, with_empty = true )
    html = "<select name=\"#{ h(name) }\" id=\"#{h(name)}\""
    options.each do | html_key, html_value |
      html += " #{h(html_key)}=\"#{h(html_value)}\""
    end
    html += ">"
    html += '<option value=""></option>' if with_empty == true
    for coll in collection do
      if coll.kind_of?(Hash)
        html += "<option value=\"#{h(coll[key])}\" #{ coll[key] == selected ? 'selected="selected"': ''}>#{ h(coll[value])}</option>"
      elsif coll.kind_of?(String)
        html += "<option value=\"#{h(coll)}\" #{ coll == selected ? 'selected="selected"': ''}>#{h(coll)}</option>"
      else
        html += "<option value=\"#{ h(coll.send( key ))}\" #{ coll.send( key ) == selected ? 'selected="selected"' : ''}>#{ h( coll.send( value ) )}</option>"
      end
    end
    html += "</select>"
    html
  end

  def content_tabs_js( tabs_simple, environment = nil, with_show_all = true )
    html = '<script type="text/javascript">'
    html += 'var tab_name = new Array();'
    if environment
      tabs_ui = tabs_simple.collect { | tab_name | "#{environment}::tab_#{tab_name}" } 
      tabs_ui.push( 'tabs::show_all' ) if with_show_all == true
      tabs_local = Momomoto::View_ui_message.find({:language_id => @current_language_id, :tag => tabs_ui})
    end
    tabs = []
    tabs_simple.each_with_index do | tab_name, index |
      tabs[index] = {}
      tabs[index][:tag] = tab_name
      tabs[index][:url] = "javascript:switch_tab('#{tab_name}');"
      tabs[index][:class] = "tab inactive"
      tabs[index][:accesskey] = index + 1
      if environment && tabs_local.find_by_id(:tag, "#{environment}::tab_#{tab_name}")
        tabs[index][:text] = tabs_local.name
      else
        tabs[index][:text] = tab_name
      end
      html += "tab_name[#{index}] = '#{tab_name}';"
    end
    if with_show_all == true
      tabs_local.find_by_id( :tag, 'tabs::show_all')
      tabs.push({:tag=>'all',:url=>"javascript:switch_tab('all')", :class=>"tab inactive", :accesskey=>0, :text=> tabs_local.current_record ? tabs_local.name : 'show all'})
    end
    html += '</script>'
    
    content_tabs( tabs, html )
  end
  
  def content_tabs( tabs, html = '' )
    html += '<div id="tabs">'
    tabs.each_with_index do | tab, index |
      html += "<span>#{ link_to(tab[:text],  tab[:url], {:accesskey => ( tab[:accesskey] || ( index + 1 )), :class => tab[:class], :id => 'tab-'+tab[:tag]})}</span>"
    end
    html += '</div>'
    html
  end

  def radio_button( name, value, checked, options = {} )
    radio_button_tag( name, value, value.to_s == checked.to_s, options )
  end

  def get_version()
    "0.2"
  end

  def get_revision()
    revision_file = '../../revision.txt'
    if File.exists?( revision_file ) && File.readable_real?( revision_file )
      rev = File.open( revision_file, 'r').gets.chomp 
    end
    rev = 2342 if rev.to_s == ''
    rev.to_s
  end

  def get_base_url()
    "https://" + @request.host + @request.env['REQUEST_URI'].gsub(/pentabarf.*/, '')
  end

end
