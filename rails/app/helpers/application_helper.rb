# Methods added to this helper will be available to all templates in the application.

require 'builder_helper'
require 'localizer'

module ApplicationHelper
  include Builder_helper

  TableRowColors = ['khaki', 'plum', 'lightgreen', 'skyblue', 'silver', 'moccasin', 'rosybrown', 'salmon', 'sandybrown']

  def pentabarf_version
    "0.3.12"
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
          tab_name = local( "#{params[:action]}::tab::#{tab}" )
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
    results_per_page = 20
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

  def event_table( events, options = {} )
    xml = Builder::XmlMarkup.new
    options[:id] ||= 'event_table'
    xml.table(:id=>options[:id],:class=>'sortable') do
      fields = [:event_state,:event_state_progress,:conference_day,:conference_room]
      xml.thead do
        xml.tr do
          xml.th(local(:event),:colspan=>2)
          fields.each do | field |
            xml.th( local("event::#{field}") )
          end
        end
      end
      xml.tbody do
        events.each do | event |
          xml.tr(:class=>event.event_state) do
            xml.td do
              xml.a({:href=>url_for(:action=>:event,:id=>event.event_id)}) do
                xml.img({:src=>url_for(:controller=>'image',:action=>:event,:id=>event.event_id,:size=>"24x24"),:height=>24,:witdh=>24})
              end
            end
            xml.td do
              xml << format_event( event )
            end
            fields.each do | field |
              xml.td do xml.a( event.send(field), {:href=>url_for(:action=>:event,:id=>event.event_id)}) end
            end
          end
        end
      end
    end
  end

  def change_url( change )
    klass = change.class.table
    if klass.columns.key?(:conference_person_id)
      cperson = Conference_person.select_single({:conference_person_id=>change.conference_person_id})
      conf = Conference.select_single({:conference_id=>cperson.conference_id})
      person = View_person.select_single({:person_id=>cperson.person_id.to_i})
      link_title = "#{conf.acronym}: #{person.name}"
      link = url_for({:action=>:person,:id=>person.person_id})
    elsif klass.columns.key?(:event_id)
      event = Event.select_single({:event_id=>change.event_id})
      conf = Conference.select_single({:conference_id=>event.conference_id})
      link_title = "#{conf.acronym}: #{event.title}"
      link = url_for({:action=>:event,:id=>event.event_id})
    elsif klass.columns.key?(:account_id)
      begin
        account = Account.select_single(:account_id=>change.account_id)
        person = View_person.select_single({:person_id=>account.person_id.to_i})
        link_title = person.name
        link = url_for({:action=>:person,:id=>change.person_id})
      rescue
        link_title = ''
        link = ''
      end
    elsif klass.columns.key?(:person_id)
      begin
        person = View_person.select_single({:person_id=>change.person_id.to_i})
        link_title = person.name
      rescue
        link_title = change.public_name
      end
      link = url_for({:action=>:person,:id=>change.person_id})
    elsif klass.columns.key?(:conference_id)
      begin
        conf = Conference.select_single({:conference_id=>change.conference_id})
        link_title = conf.title
        link = url_for({:action=>:conference,:id=>conf.conference_id})
      rescue
        link_title = change.respond_to?(:title) ? change.title : ""
        link = ""
      end
    elsif klass.table_name.match(/_localized$/)
      link_title = "Localization"
      link = url_for(:controller=>'localization',:action=>klass.table_name.gsub(/_localized$/,''))
    else
      link_title = klass.table_name.capitalize
      link = ""
    end
    [link,link_title]
  end

  def changeset_changes( changeset )
    xml = Builder::XmlMarkup.new
    xml.ul do
      Log_transaction_involved_tables.select({:log_transaction_id=>changeset.log_transaction_id}).map(&:table_name).each do | table |
        # FIXME ignoring some tables for now
        next if table == "person_availability"
        klass = table.capitalize.constantize
        log_klass = "Log::#{table.capitalize}".constantize

        log_klass.select(:log_transaction_id=>changeset.log_transaction_id).each do | change |

          values = []
          columns = klass.columns.keys - [:eval_time,:reset_time,:account_creation]
          columns = columns.map(&:to_s).sort.map(&:to_sym)
          if change.log_operation == "D" || change.log_operation == "I"
            columns = columns - [:password,:salt,:activation_string]
            columns.each do | column |
              next if klass.columns[column].instance_of?( Momomoto::Datatype::Bytea )
              next unless change[column]
              next if klass.primary_keys.member?( column ) && column.to_s.match(/_id$/)
              values << "#{local(table.to_s+'::'+column.to_s)}: #{change[column]}"
            end
            next if values.length == 0 && change.log_operation == "I"
          else
            conditions = {:log_transaction_id=>{:lt=>change.log_transaction_id}}
            klass.primary_keys.each do | pk | conditions[pk] = change[pk] end
            old_value = log_klass.select(conditions,{:order=>Momomoto.desc(:log_transaction_id),:limit=>1})[0]
            if old_value
              values = []
              columns.each do | column |
                if change[column] != old_value[column]
                  if klass.columns[column].instance_of?( Momomoto::Datatype::Bytea ) || [:password,:salt,:activation_string].member?(column)
                    values << "#{local(table.to_s+'::'+column.to_s)} changed"
                  else
                    values << "#{local(table.to_s+'::'+column.to_s)}: #{old_value[column]} => #{change[column]}"
                  end
                end
              end
            else
              values << "Couldn't find previous value."
            end
          end

          xml.li do
            link, link_title = change_url( change )

            xml.a({:href=>link,:title=>table}) do
              xml.text! link_title
              xml.br

              xml.b case change.log_operation
                when "D" then "Deleted #{local(table)}: "
                when "I" then "New #{local(table)}: "
                when "U" then "#{local(table)}: "
              end
              xml.text! values.join(", ")
            end
          end
        end

      end
    end
  end

end
