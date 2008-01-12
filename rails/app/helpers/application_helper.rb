# Methods added to this helper will be available to all templates in the application.

require 'builder_helper'
require 'localizer'

module ApplicationHelper
  include Builder_helper

  TableRowColors = ['khaki', 'plum', 'lightgreen', 'skyblue', 'silver', 'moccasin', 'rosybrown', 'salmon', 'sandybrown']

  def pentabarf_version
    "0.3.9"
  end

  # tries to read the current revision of pentabarf from subversion meta data
  def pentabarf_revision
    if not self.class.class_variables.member?( '@@revision' )
      revision_file = File.join( RAILS_ROOT, '..', '.svn', 'entries' )
      begin
        content = File.open( revision_file, 'r').read
        if content[0..1] == '<?'    # new svn xml file
          d = REXML::Document.new( content )
          rev = d.elements['//entry[@name=""]/@revision'].to_s
        else                        # simple txt file
          rev = content.split("\n")[3]
        end
        rev = rev.to_i
      rescue
        rev = 0
      end
      @@revision = rev
    end
    @@revision.to_s
  end

  def local( tag )
    Localizer.lookup( tag.to_s, @current_language )
  end

  def js( text )
    text.to_s.gsub(/[<>]/, '').gsub( '\\', '\0\0' ).gsub(/\r\n|\n|\r/, "\\n").gsub(/["']/, '\\\\\0')
  end

  def js_function( name, *parameter )
    parameter.map! do | p |
      if p == true then "true"
      elsif p == false then "false"
      elsif p == nil then "null"
      else "'#{js(p.to_s)}'" end
    end
    "#{name}(#{parameter.join(',')});"
  end

  def js_tabs( tabs )
    xml = Builder::XmlMarkup.new
    xml.div( :id => 'tabs' ) do
      tabs.each_with_index do | tab, index |
        if tab.instance_of?( Array ) 
          tab_name = tab.last
          tab = tab.first
        else
          tab_name = tab.to_s
        end
        xml.span( tab_name, {:id=>"tab-#{tab}",:onclick=>"switch_tab('#{tab}')",:class=>'tab inactive',:accesskey=>index+1} )
      end
      xml.span( 'Show all', {:id=>"tab-all",:onclick=>"show_all_tabs()",:class=>'tab inactive',:accesskey=>0} )
    end
  end

  def schedule_table( conference, events )
    table = {}
    timeslot_seconds = conference.timeslot_duration.hour * 3600 + conference.timeslot_duration.min * 60
    slots_per_day = ( 24 * 60 * 60 ) / timeslot_seconds
    start = (conference.day_change.hour * 3600) + (conference.day_change.min * 60) + conference.day_change.sec
    # create an array for each day
    days = Conference_day.select({:conference_id=>conference.conference_id},{:order=>:conference_day}).map(&:conference_day)
    days.each do | d | table[d.to_s] = [] end
    # fill array with times
    table.each do | conference_day, day_table |
      current = 0
      while current < 24 * 60 * 60
        table[conference_day].push( { 0 => sprintf("%02d:%02d", ((current + start)/3600)%24, ((current + start)%3600)/60 ) } )
        current += timeslot_seconds
      end
    end
    events.each do | event |
      slots = (event.duration.hour * 3600 + event.duration.min * 60)/timeslot_seconds
      start_slot = (event.start_time.hour * 3600 + event.start_time.min * 60) / timeslot_seconds
      next if table[event.conference_day.to_s][start_slot][event.conference_room]
      table[event.conference_day.to_s][start_slot][event.conference_room] = {:event_id => event.event_id, :slots => slots}
      slots.times do | i |
        next if i < 1
        # check whether the event spans multiple days
        if (start_slot + i) >= slots_per_day
          if (start_slot + i)%slots_per_day == 0
            table[(event.conference_day + (start_slot + i)/slots_per_day).to_s][(start_slot + i)%slots_per_day][event.conference_room] = {:event_id => event.event_id, :slots => slots - i}
          else
            table[(event.conference_day + (start_slot + i)/slots_per_day).to_s][(start_slot + i)%slots_per_day][event.conference_room] = 0
          end
        else
          table[event.conference_day.to_s][start_slot + i][event.conference_room] = 0
        end
      end
    end
    table.each do | conference_day, day_table |
      while day_table.first && day_table.first.length == 1
        day_table.delete(day_table.first)
      end
      while day_table.last && day_table.last.length == 1
        day_table.delete(day_table.last)
      end
    end
    table
  end

  def markup( text )
    BlueCloth.new( text.to_s, :filter_html ).to_html
   rescue
    "BlueCloth error"
  end

  def paginate( xml, results, active_page )
    results_per_page = 42
    show_first, show_last, show_around = 3, 3, 4
    pages = (results.length / results_per_page.to_f).ceil
    active_page = pages - 1 if active_page >= pages
    xml.div do
      xml.span "#{results.length} results found."
      xml.br
      pages.times do | page |
        xml.text! "..." if page == show_first && active_page >= ( show_first + show_around )
        xml.text! "..." if page == ( pages - show_last ) && active_page < ( pages - ( show_last + show_around ) )
        next if page >= show_first && page < ( pages - show_last ) && ( page <= ( active_page - show_around) || page >= ( active_page + show_around ) )
        xml.button("#{page+1}",{:type=>:button,:class=>"paginate #{page==active_page ? :active : nil}",:onclick=>"new Ajax.Updater('results','#{url_for(:id=>page)}');"})
      end if results.length > results_per_page
    end
    yield( results[(active_page * results_per_page)..((active_page+1) * results_per_page - 1 )] || [] )
    xml.div do
      pages.times do | page |
        xml.text! "..." if page == show_first && active_page >= ( show_first + show_around )
        xml.text! "..." if page == ( pages - show_last ) && active_page < ( pages - ( show_last + show_around ) )
        next if page >= show_first && page < ( pages - show_last ) && ( page <= ( active_page - show_around) || page >= ( active_page + show_around ) )
        xml.button("#{page+1}",{:type=>:button,:class=>"paginate #{page==active_page ? :active : nil}",:onclick=>"new Ajax.Updater('results','#{url_for(:id=>page)}');"})
      end if results.length > results_per_page
    end
  end

  def conference_track_color_div( tracks, track_color )
    xml = Builder::XmlMarkup.new

    xml.div({:id=>:colors}) do
      tracks.each_with_index do | track, index |
        track_color[track.conference_track] = TableRowColors[index % TableRowColors.length]
        xml.span({:style=>"margin: 20px 3px;padding: 5px 15px; background-color: #{track_color[track.conference_track]}"}) do
          xml.strong(track.conference_track)
        end
      end
    end
    xml
  end

  def format_event( event )
    xml = Builder::XmlMarkup.new
    xml.a({:href=>url_for(:controller=>'pentabarf',:action=>:event,:id=>event.event_id)}) do
      xml.strong event.title
      if event.subtitle
        xml.br
        xml.text! event.subtitle
      end
      if event.respond_to?( :speaker_ids ) && event.speaker_ids
        ids = event.speaker_ids.split("\n")
        names = event.speakers.split("\n")
        xml.ul(:class=>'event-persons') do
          ids.each_with_index do | id, index |
            xml.li do xml.a( names[index], {:href=>url_for(:controller=>'pentabarf',:action=>:person,:id=>id)}) end
          end
        end
      end
    end
    xml
  end

end
