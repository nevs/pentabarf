# The methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def select_tag( name, collection, key, value, selected, options = {}, with_empty = true )
    html = "<select name=\"#{ h(name) }\""
    options.each do | html_key, html_value |
      html += " #{h(html_key)}=\"#{h(html_value)}\""
    end
    html += ">"
    html += '<option value=""></option>' if with_empty == true
    for coll in collection do
      if coll.kind_of?(Hash)
        html += "<option value=\"#{h(coll[key])}\" #{ coll[key] == selected ? 'selected=\"selected\"': ''}>#{ h(coll[value])}</option>"
      elsif coll.kind_of?(String)
        html += "<option value=\"#{h(coll)}\" #{ coll == selected ? 'selected=\"selected\"': ''}>#{h(coll)}</option>"
      else
        html += "<option value=\"#{ h(coll.send( key ))}\" #{ coll.send( key ) == selected ? 'selected=\"selected\"' : ''}>#{ h( coll.send( value ) )}</option>"
      end
    end
    html += "</select>"
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
    rev
  end

  def get_base_url()
    "https://" + @request.host + @request.env['REQUEST_URI'].gsub(/pentabarf.*/, '')
  end

end
