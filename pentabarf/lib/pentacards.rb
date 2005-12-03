# Pentacard generator v0.1
# Thomas Kollbach <toto@bitfever.de>
#
# CAUTION: This file has to be ISO Latin 1. Don't convert to UTF-8 as PDF::Writer does not support Unicode.
# USES ONLY DUMMY DATA - NO LIVE DATA YET
# 
require 'config/environment.rb'
require 'rubygems'
require 'iconv'
require_gem 'pdf-writer'

class Pentcards
 
  def initialize(mo_events, rows, cols, paper_dimensions=[21.0, 29.7])
    @converter = Iconv.new('iso-8859-15', 'UTF-8')
    @language_id = 120
    @border_between_cards = 1 #in cm
    
    # we ignore custom col and row settigns for now, till the layout can cope with it.
    @cols = 2
    @rows = 2
    @pages = ( mo_events.length / ( @cols * @rows )).ceil
    
    # select optimal orientation
    orientation = @cols >= @rows ? :landscape : :portrait
    
    @margin = 40
    
    # calculate sizes of a single card
    @card_width = (PDF::Writer.cm2pts(paper_dimensions[1] - @border_between_cards) - @margin*2) / @cols
    @card_height = (PDF::Writer.cm2pts(paper_dimensions[0] - @border_between_cards)  - @margin*2) / @rows
    
    @pdf = PDF::Writer.new(:paper => paper_dimensions, :orientation => orientation)
    @pdf.select_font "Helvetica"
    @pdf.margins_pt(@margin)
 
    counter, page = 0, 0
    
    mo_events.each do | event |
    
      if counter == 4
        page += 1 
        @pdf.start_new_page 
        counter = 0 

      end
      col = (counter) % 2
      row = (counter) / 2
      
      draw_layout( event.event_id, col, row )
      counter += 1
    end
  end
  
  def write_text(col,row,page)
    
  end
  
  def render
    return @pdf.render
  end
  
  protected

  def create_card(event,args={})  
    return
    1..@pages.each do | page |
      0...@cols.each do |col|
        0...@rows.each do |row|
          draw_layout(event,col,row,
                  {:card_border => true})
          #draw_page(col,row)
        end  
      end
      # start a new page and move the writing pointer to thenew pages top margin
      @pdf.start_new_page if page > 1
    end
  end
  
  def draw_layout( event_id, col, row, args={})
    event = Momomoto::View_event.find({:translated_id=> @language_id, :event_id => event_id})

    this_event = {'event_type' => convert(event.event_type),
            'event_state' => convert(event.event_state),
            'event_state_progress' => Momomoto::View_event_state_progress.find({:language_id => @language_id, :event_state_id => event.event_state_id}).name,
            'subtitle' => convert(event.subtitle),
            'title' => convert(event.title),
            'id' => event.event_id.to_s,
            'tag' => convert(event.tag),
            'duration' => "#{event.duration.hour.to_s unless event.duration.nil?}#{event.duration.nil? ? '': ':'}#{if event.duration.min<10 then '0'+ event.duration.min.to_s else event.duration.min.to_s end unless event.duration.nil?}",
            'start_time' => "#{event.start_time.hour.to_s unless event.start_time.nil?}#{event.start_time.nil? ? '' : ':'}#{if event.start_time.min<10 then '0'+ event.start_time.min.to_s else event.start_time.min.to_s end unless event.start_time.nil?}",
            'day' => "#{event.day}",
            'room' => event.room.to_s,
            'abstract' => event.abstract.to_s
            }
    
    this_event.each do | key, value |
      puts "#{key}: #{value}"
      begin
        value = @converter.iconv( value.to_s )
      rescue
        next
      end
    end
     
    # compose the display sting for all languages:
    langs_str = ""
    langs_str = Momomoto::View_conference_language.find({:language_id => event.language_id, :translated_id=> @language_id, :conference_id=>event.conference_id}).name
    
    # keep in mind that these have to be ordered the same way
    last_row_content = [ event.conference_track.to_s ,
                         "#{this_event['event_state']}\n#{this_event['event_state_progress']}",
                         langs_str,
                         this_event['event_type'] ]
    
    last_row_content.each_with_index do | item, index |
      draw_text_box( col, row, { :text => @converter.iconv( item ),
                                 :width => (@card_width / last_row_content.size),
                                 :height => 26,
                                 :x => 0 + ((@card_width /last_row_content.size ) * index) ,
                                 :y => 0,
                                 :bgcolor => '#fff',
                                 :left_margin => 0,
                                 :top_margin => 0,
                                 :border_color => '#000',
                                 :border_size => 0,
                                 :align => :center,
                                 :font_size => 12 } )  
    end
    
    annote_row_prelimanary = [this_event['day'],this_event['room'],this_event['start_time'],this_event['duration']]
    
    annote_row_prelimanary.each_with_index do |item,index|
        draw_text_box(col,row,{:text =>item,
                       :width => (@card_width / annote_row_prelimanary.size),
                       :height => 42,
                       :x => 0 + ((@card_width /annote_row_prelimanary.size ) * index) ,
                       :y => 43,
                       :left_margin => 0,
                       :top_margin => 0.4,
                       :border_size => 1,
                       :border_color => '#ababab',
                       :text_color => '#ababab',
                       :align => :center,
                       :font_size => 18})
                     end
        
    annote_row_title = ['table::event::day','table::event::room','table::event::start_time','table::event::duration']
    
    # Draw Perosns box
    persons = Momomoto::View_event_person.find({:event_id => event.event_id, :language_id => @language_id})

    persons_str = ""
    
    speakers, moderators, coordinators = Array.new, Array.new, Array.new
    
    persons.each do |person|
      speakers << "<b>#{person.event_role_tag.capitalize[0..0]}</b>: #{person.name}\n" if person.event_role_tag == 'speaker'
      moderators << "<b>#{person.event_role_tag.capitalize[0..0]}</b>: #{person.name}\n" if person.event_role_tag == 'moderator'
      coordinators << "<b>#{person.event_role_tag.capitalize[0..0]}</b>: #{person.name}\n" if person.event_role_tag == 'coordinator'
    end

      persons = speakers + moderators + coordinators
      persons_str = persons.join.to_str

    draw_text_box( col, row, { :text => persons_str,
                               :width => 130,
                               :height => 70,
                               :x => 0,
                               :y =>88,
                               :text_color => '#000',
                               :left_margin => 0.2,
                               :top_margin => 0,
                               :border_size => 0,
                               :align => :left,
                               :font_size => 10 } )
 
#                    :bgcolor => '#ababab',
    # write abstarct
    #FIXME
    abstract_title = ""
    abstract_text =  this_event['abstract']
  
  #HACK HACK HACK WORKAROUND for the UTF -> ISO conversion problems.   
  begin
    abstract_str = "<b>#{Iconv.iconv("iso-8859-1","UTF-8",abstract_title)}</b>\n#{Iconv.iconv("iso-8859-1","UTF-8",abstract_text)}"
  rescue
    
      array = "<b>#{abstract_title}</b>\n#{abstract_text}".split(/./)
      array.each_with_index do |item,index|
       begin
        array[index] = Iconv.iconv("iso-8859-1","UTF-8",item)
       rescue
        # could not convert char so replacing with " "
        array[index] = " "
       end
      end
      abstract_str = array.join
  end
    
    draw_text_box(col,row,{  :text => abstract_str,
                    :width => 236,
                    :height => 83,
                    :x => 131,
                    :y => 91,
                    :text_color => '#000',
                    :bgcolor => '#fff',
                    :left_margin => 0.2,
                    :top_margin => 0.3,
                    :border_color => '#00f',
                    :border_size => 0,
                    :align => :left,
                    :font_size => 9})
    
    
    # Subtitle 
    draw_text_box(col,row,{  :text => this_event['subtitle'],
                    :width => 296,
                    :height => 37,
                    :x => 70,
                    :y => @card_height - 34 - 36 - 4,
                    :text_color => '#000',
                    :left_margin => 0.2,
                    :top_margin => 0,
                    :border_size => 0,
                    :align => :left,
                    :font_size => 15})
                    
   #title in the top
   draw_text_box(col,row,{  :text => "<b>#{this_event['title']}</b>",
                    :width => 225,
                    :height => 36,
                    :x => 70,
                    :y => @card_height - 32 ,
                    :text_color => '#000',
                    :left_margin => 0.2,
                    :top_margin => 0.1,
                    :border_size => 0,
                    :align => :left,
                    :font_size => 18}) 
                    

                    
   #ID top right corner
   if this_event['id']
   draw_text_box(col,row,{  :text => "<b>#{this_event['id']}</b>".strip,
                    :width => 80,
                    :height => 34,
                    :x => @card_width - 79,
                    :y => (@card_height - 34).abs,
                    :text_color => '#fff',
                    :bgcolor => '#000',
                    :left_margin => 0,
                    :top_margin => 0.1,
                    :border_size => 0,
                    :align => :center,
                    :font_size => 21})
  end
  # HACK should be definde some reasonable palce not hardcoded:
  $site_url = "pentabarf.cccv.de"
  # insert image
  puts (this_event['id']).to_i
  begin
   # pdf-writer does not like png tranparency
   event_image = Momomoto::View_event_image.find( {:event_id => (this_event['id']).to_i } ).image
   add_image(col,row,event_image,5,@card_height - 50,60,60,"http://#{$site_url}/pentabarf/event/#{this_event['id']}")
  rescue
  end
  
                    
  # Draw a border around the boxes for cutting
  # - this is done last, to darw above al whitend borders that may have been drawn before
  #draw_text_box(col,row,{:x => 0,
  #               :y => 0,
   #              :width => @card_width,
    #              :height => @card_height,
    #             :border_size => 0
     #            }) #if args[:card_border]
  end

  # converts a string and replaces unconvertable characters with whitespace
  def convert( text )
    begin
      converted = @converter.iconv( text.to_s )
    rescue
      converted = ''
      text.to_s.each_byte do | byte |
        begin
          byte = @converter.iconv( text )
        rescue
          byte = ' '
        end
        converted += byte
      end
    end
    return converted
  end
  
  def draw_text_box(col,row,args={})
  
    text = convert( args[:text] )
    
    # default text align is left
    text_align = args[:align] || :left
    
    # default placing of text is top left
    align = args[:align] || 'left'
    vlaign = args[:vlaign] || 'top'
    
    # set colors or set to default colorset:
    
    text_color =  args[:text_color]  || '#000'
    
    if args[:bgcolor] =~ /#0(000)?00/
        puts "schwarz x: #{args[:x]} y: #{args[:y]}"
    end
    if  args[:bgcolor] then
      @pdf.fill_color(Color::RGB.from_html(args[:bgcolor]))  
      fill = true 
    else
      fill = false
    end

    @pdf.stroke_color(Color::RGB.from_html(args[:border_color] || '#000000'))
    
    # sizes of fonts an lines
    font_size = args[:font_size] || 12 # in points (font sizes)
    
    @line_thick =  args[:border_size] || 1
    if @line_thick == 0 
      border = false
    else
      border = true
      @pdf.stroke_style(PDF::Writer::StrokeStyle.new(@line_thick)) # in pixes
    end
    # inner margins in centimeterss
    top_margin = PDF::Writer.cm2pts(args[:top_margin] || 0.2)
    left_margin = PDF::Writer.cm2pts(args[:left_margin] || 0.2)
    
    # overflow props
    overflow = args[:overflow] || 'hidden'
    
    # set drawpoint (keep in mind the border)
    x = col * (@card_width + PDF::Writer.cm2pts(@border_between_cards)) + @margin + (args[:x] || 0)
    y = row * (@card_height + PDF::Writer.cm2pts(@border_between_cards)) + @margin + (args[:y] || 0)
   
    ## draw box 
    # nonsense default, this should not me mandatory! just for testing
    #FIXME
    width = (args[:width] || 20) 
    height = (args[:height] || 20) 
    
    
    draw_rect(x,y,width,height,fill,border)

    render_text({:text => text,
             :text_color => text_color,
             :font_size => font_size,
             :text_align => text_align,
             :x => x + left_margin,
             :y => y + height - font_size + (@line_thick * 2 - top_margin),
             :width => width - ((@line_thick + left_margin) * 2),
             :height => height,
             :top_margin => top_margin,
             :left_margin => left_margin})
  end

  def render_text(args={})
    if args[:text] != ""
    # get ready for front writing
      @pdf.fill_color(Color::RGB.from_html(args[:text_color])) 
      @pdf.stroke_color(Color::RGB.from_html(args[:text_color]))


      org_text = args[:text]
      
      # make paragraphs
      if org_text.rindex("\n") && org_text.rindex("\n") > 0 
       text = org_text[0,org_text.index("\n")]
       
       #render this line
       rest_text = @pdf.add_text_wrap( args[:x],
                            args[:y],
                            args[:width],
                            text,
                            args[:font_size],
                            args[:text_align])
       rest_text =  rest_text + org_text[org_text.index("\n")+1,org_text.size-1]

      else

       text = args[:text]
       
       #render this line
       rest_text = @pdf.add_text_wrap( args[:x],
                            args[:y],
                            args[:width],
                            text,
                            args[:font_size],
                            args[:text_align])
      end



      
      # render everything but the last lines that fits or overflow if said to
      if args[:overflow] || args[:height] >= args[:font_size]
       line_space = args[:font_size] * (args[:line_spacing] || 1)
       line_space = line_space.round + 1

       render_text({:text => rest_text,
                :text_color => args[:text_color] || '#000000',
                :x => args[:x],
                :y => args[:y] - line_space,
                :width => args[:width],
                :height => args[:height] - args[:font_size] - line_space,
                :top_margin => 0,
                :left_margin => 0,
                :font_size => args[:font_size],
                :text_align => args[:text_align]}) 
     # append three dots to the last line and render it

     else
      # or break recursion
      return
     end
    else
     return
    end
  end

  def draw_rect(x,y,width,height,fill=false,border=true)
    @pdf.rectangle(x,y,width,height).fill if fill
    @pdf.rectangle(x,y,width,height).close_stroke if border
  end  

  def add_image(col,row,image,x,y,width=nil,height=nil,link=nil)
    x = col * (@card_width + PDF::Writer.cm2pts(@border_between_cards)) + @margin + (x || 0)
    y = row * (@card_height + PDF::Writer.cm2pts(@border_between_cards)) + @margin + (y || 0)
   
    @pdf.add_image(image,x,y,width,height,nil,link)
  end
end
