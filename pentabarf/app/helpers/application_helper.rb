require 'markup_html'
require 'markup_fo'

# The methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def js( text )
    escape_javascript( text )
  end

  def text_field( object, fieldname, options = {} )
    value = object.send( fieldname )
    options[:maxlength] = object.field( fieldname ).property(:length) if object.field( fieldname ).property(:length)
    text_field_tag( "#{object.class.table_name}[#{fieldname}]", value, options )
  end

  def rating_bar( ratings, field )
    count, sum = 0, 0
    for rating in ratings
      next if rating[field].to_i == 0
      count += 1
      sum += ( rating[field].to_i - 3 )
    end
    if count > 0
      average = ( ( sum * 5 ) / count ).to_i * 10
      v_pos = average >= 0 ? average : nil
      v_neg = average < 0 ? average : nil
    else
      v_pos, v_neg = 0, nil
    end

    html = '<td class="rating-bar">'
    html += "<span class=\"negative p#{ v_neg ? v_neg.abs : '0'}\">#{ v_neg }</span>"
    html += '</td>'
    html += '<td class="rating-bar">'
    html += "<span class=\"positive p#{ v_pos ? v_pos : '0'}\">#{ v_pos }</span>"
    html += '</td>'
    html += "<td>#{count.to_i}</td>"
    html
  end

  def markup( text, writer=Markup::HTMLWriter.new )
    text = h( text )
    allowed_protocols = ['http', 'https', 'mailto', 'svn', 'xmpp']

    nesting, new_text, p_open, is_text = '', '', false, true
    (text.split(/\n/) + ['']).each do | line |
      # close <p> tag for lists
      if line.match(/^[*#-]/) and p_open
        new_text += writer.close_paragraph
        p_open = false
      end

      new_nesting = line.match(/^[*#-]+/).to_s.gsub('-','*')
      # lists #,- and * with nesting
      if new_nesting != nesting
        while nesting != new_nesting[0...nesting.length].to_s
          new_text += nesting[nesting.length - 1].chr == '#' ?
              writer.close_ordered_list :
              writer.close_unordered_list
          nesting[nesting.length - 1] = ''
          new_text += writer.close_list_item if nesting.size > 0
        end
        while new_nesting != nesting
          new_text += writer.open_list_item if nesting.size > 0
          new_text += new_nesting[nesting.length].chr == '#' ?
              writer.open_ordered_list :
              writer.open_unordered_list
          nesting += new_nesting[nesting.length].chr
        end

        is_text = false
      end

      line.gsub!( /^[#*-]+(.*)$/, writer.open_list_item + '\1' + writer.close_list_item )

      # internal links [[type:id]] or [[type:id label]]
      line.gsub!( /\[\[[^\]]+\]\]/ ) do | ilink |
        if match = ilink[2..-3].match( /^([^: ]+):([^: ]+)( (.+))?$/ )
          ilink = writer.open_link("#{url_for(:action=>match[1],:id=>match[2])}") + (match[4] ? match[4] : match[1] + ':' + match[2]) + writer.close_link
        end
        ilink
      end
      # external links [url] or [url label]
      line.gsub!( /\[[^\]]+\]/ ) do | elink |
        if match = elink[1..-2].match( /^(([a-z]+):(\/\/)?([^ ]+))( (.+))?$/ )
          elink = "<a href=\"#{match[1]}\">#{match[6] ? match[6] : match[1]}</a>" if allowed_protocols.member?(match[2])
          elink = writer.open_link("#{match[1]}") + (match[6] ? match[6] : match[1]) + writer.close_link if allowed_protocols.member?(match[2])
        end
        elink
      end
      # //italics// **bold** __underlined__
      line.gsub!( /\/\/([^\/]+)\/\//, writer.open_italic + '\1' + writer.close_italic )
      line.gsub!( /\*\*([^*]+)\*\*/, writer.open_bold + '\1' + writer.close_bold )
      line.gsub!( /__([^_]+)__/, writer.open_underline + '\1' + writer.close_underline )
      # Header 1 - 6
      is_text = false if line =~ /^={1,6}[^=]+={1,6}$/
      line.gsub!( /^======([^=]+)======$/, writer.open_headline(6) + '\1' + writer.close_headline)
      line.gsub!( /^=====([^=]+)=====$/, writer.open_headline(5) + '\1' + writer.close_headline)
      line.gsub!( /^====([^=]+)====$/, writer.open_headline(4) + '\1' + writer.close_headline)
      line.gsub!( /^===([^=]+)===$/, writer.open_headline(3) + '\1' + writer.close_headline)
      line.gsub!( /^==([^=]+)==$/, writer.open_headline(2) + '\1' + writer.close_headline)
      line.gsub!( /^=([^=]+)=$/, writer.open_headline(1) + '\1' + writer.close_headline)
      # :blockquote
      is_text = false if line =~ /^:.*$/
      line.gsub!( /^:(.*)$/, writer.open_blockquote + '\1' + writer.close_blockquote )

      # empty line forces new <paragraph>
      if line.strip.match(/^$/) and p_open
        new_text += writer.close_paragraph
        p_open = false
      end

      # close <p> tag for header and blockquote
      if not is_text and p_open
        new_text += writer.close_paragraph
        p_open = false
      end

      # open <p> tag unless header, blockquote or listelement
      if not p_open and is_text and line.strip.length > 0
        new_text += writer.open_paragraph
        p_open = true
      end

      new_text += line + "\n"
    end
    new_text += writer.close_paragraph if p_open
    new_text
  end

  def localize_tag( tag )
    localized = Momomoto::View_ui_message.find({:tag=>tag, :language_id=>Momomoto::ui_language_id})
    localized.length == 1 ? localized.name : tag
  end

  def person_image( person_id = 0, size = 32, extension = nil )
    size = 500 if size > 500
    url_for({:controller=>'image',:action=>:person,:id=>person_id}) + "-#{size}x#{size}" + ( extension ? ".#{extension}" : '')
  end

  def event_image( event_id = 0, size = 32, extension = nil )
    size = 500 if size > 500
    url_for({:controller=>'image',:action=>:event,:id=>event_id}) + "-#{size}x#{size}" + ( extension ? ".#{extension}" : '')
  end

  def conference_image( conference_id = 0, size = 32, extension = nil )
    size = 500 if size > 500
    url_for({:controller=>'image',:action=>:conference,:id=>event_id}) + "-#{size}x#{size}" + ( extension ? ".#{extension}" : '')
  end

  def schedule_table( conference, events )
    table = []
    timeslot_seconds = conference.timeslot_duration.hour * 3600 + conference.timeslot_duration.min * 60
    slots_per_day = ( 24 * 60 * 60 ) / timeslot_seconds
    start = (conference.day_change.hour * 3600) + (conference.day_change.min * 60) + conference.day_change.sec
    # create an array for each day
    conference.days.times do | i | table[i] = [] end
    # fill array with times
    table.each_with_index do | day_table, day |
      current = 0
      while current < 24 * 60 * 60
        table[day].push( [ sprintf("%02d:%02d", ((current + start)/3600)%24, ((current + start)%3600)/60 ) ] )
        current += timeslot_seconds
      end
    end
    events.each do | event |
      slots = (event.duration.hour * 3600 + event.duration.min * 60)/timeslot_seconds
      start_slot = (event.start_time.hour * 3600 + event.start_time.min * 60) / timeslot_seconds
      next if table[event.day - 1][start_slot][event.room_id]
      table[event.day - 1][start_slot][event.room_id] = {:event_id => event.event_id, :slots => slots}
      slots.times do | i |
        next if i < 1
        # check whether the event spans multiple days
        if (start_slot + i) >= slots_per_day
          if (start_slot + i)%slots_per_day == 0
            table[event.day - 1 + (start_slot + i)/slots_per_day][(start_slot + i)%slots_per_day][event.room_id] = {:event_id => event.event_id, :slots => slots - i}
          else
            table[event.day - 1 + (start_slot + i)/slots_per_day][(start_slot + i)%slots_per_day][event.room_id] = 0
          end
        else
          table[event.day - 1][start_slot + i][event.room_id] = 0
        end
      end
    end
    table.each do | day_table |
      while day_table.first && day_table.first.length == 1
        day_table.delete(day_table.first)
      end
      while day_table.last && day_table.last.length == 1
        day_table.delete(day_table.last)
      end
    end
    table
  end

  def select_tag( name, collection, key, value, selected, options = {}, with_empty = true )
    html = "<select name=\"#{ h(name) }\" id=\"#{h(name)}\""
    options.each do | html_key, html_value |
      html += " #{h(html_key)}=\"#{h(html_value)}\""
    end
    html += ">"
    html += '<option value=""></option>' if with_empty == true
    collection.each do | coll |
      if coll.kind_of?(Array) || coll.kind_of?(Hash)
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
    tabs_ui = []
    if environment
      tabs_ui = tabs_simple.collect do | tab_name |
        "#{environment}::#{tab_name.kind_of?(Hash) ? tab_name[:tag] : tab_name}"
      end
    end
    tabs_ui.push( 'tabs::show_all' ) if with_show_all == true
    tabs_local = Momomoto::View_ui_message.find({:language_id => @current_language_id, :tag => tabs_ui}) if environment || with_show_all
    tabs = []
    tabs_simple.each_with_index do | tab_name, index |
      tabs[index] = {}
      cur_tab_name = tab_name.kind_of?(Hash) ? tab_name[:tag] : tab_name
      tabs[index][:tag] = cur_tab_name
      tabs[index][:url] = tab_name.kind_of?(Hash) && tab_name[:url] ? tab_name[:url] : "javascript:switch_tab('#{cur_tab_name}');"
      tabs[index][:class] = "tab inactive"
      tabs[index][:accesskey] = index + 1
      if environment && tabs_local.find_by_id(:tag, "#{environment}::#{tabs[index][:tag]}")
        tabs[index][:text] = tabs_local.name
      else
        tabs[index][:text] = tab_name.kind_of?(Hash) && tab_name[:text] ? tab_name[:text] : cur_tab_name
      end
      html += "tab_name[#{index}] = '#{cur_tab_name}';"
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
      html += "<span>#{ link_to(h(tab[:text].to_s),  tab[:url].to_s, {:accesskey => ( tab[:accesskey] || ( index + 1 )), :class => tab[:class].to_s, :id => 'tab-'+tab[:tag].to_s})}</span>"
    end
    html += '</div>'
    html
  end

  # returns the current version of pentabarf
  def get_version()
    "0.2.7"
  end

  # tries to read the current revision of pentabarf from a file named revision.txt otherwise returns 2342
  def get_revision()
    revision_file = '../../revision.txt'
    rev = 0
    if File.exists?( revision_file ) && File.readable_real?( revision_file )
      rev = File.open( revision_file, 'r').gets.chomp.to_i
    end
    rev = 2342 if rev == 0
    rev.to_s
  end

  def get_base_url()
    "https://" + @request.host + @request.env['REQUEST_URI'].gsub(/(pentabarf|submission|visitor|feedback).*/, '')
  end

  def sanitize_track( track )
    track = track.to_s.downcase.gsub(/[^a-z0-9]/, '')
    return track == '' ? '' : h("track-#{track}")
  end

  def radio_button( name, value, curval )
    check = value.to_s == curval.to_s ? ' checked="checked"' : ''
    "<input type=\"radio\" name=\"#{name}\" value=\"#{h(value)}\" tabindex=\"0\"#{check}/>"
  end

  # overwrite the default text_area_tag function from rails which lacks proper escaping
  def text_area_tag(name, content = nil, options = {})
    options.stringify_keys!
    if size = options.delete("size")
      options["cols"], options["rows"] = size.split("x")
    end
    content_tag :textarea, h(content), { "name" => name, "id" => name }.update(options.stringify_keys)
  end

end
