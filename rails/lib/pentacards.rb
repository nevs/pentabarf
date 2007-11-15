# Pentacard generator v0.1
# Thomas Kollbach <toto@bitfever.de>
# Sven Klemm <sven@c3d2.de>
#
# CAUTION: This file has to be ISO Latin 1. Don't convert to UTF-8 as PDF::Writer does not support Unicode.
#

require 'iconv'
require 'pdf/writer'

class Pentacards

  def initialize( events, rows, cols, paper_dimensions=[21.0, 29.7])
    @converter = Iconv.new('iso-8859-15', 'UTF-8')
    @language_id = 120
    @border_between_cards = 1 #in cm

    # we ignore custom col and row settigns for now, till the layout can cope with it.
    @cols = 2
    @rows = 2
    @pages = ( events.length / ( @cols * @rows )).ceil

    # select optimal orientation
    orientation = @cols >= @rows ? :landscape : :portrait

    @margin = 40

    # calculate sizes of a single card
    @card_width = (PDF::Writer.cm2pts(paper_dimensions[1] - @border_between_cards) - @margin*2) / @cols
    @card_height = (PDF::Writer.cm2pts(paper_dimensions[0] - @border_between_cards)  - @margin*2) / @rows

    @pdf = PDF::Writer.new(:paper => paper_dimensions, :orientation => orientation)
    @pdf.select_font "Helvetica"
    @pdf.margins_pt(@margin)

    events.each_with_index do | event, index |
      @pdf.start_new_page if index % (@cols * @rows) == 0 and index > 0

      col = index % 2
      row = (index % 4)/ 2

      draw_event( event, col, row )
    end
  end

  def render
    return @pdf.render
  end

  protected

  def draw_event( event, col, row, args={})
    language = View_language.select({:language_id => event.language_id.to_i, :translated => @language_id})

    # this is the bottom line with track, state language and event type
    output_row = [ event.conference_track,
                   "#{event.event_state}\n#{event.event_state_progress}",
                   language[0] ? language[0].name : '',
                   event.event_type ]

    output_row.each_with_index do | item, index |
      draw_text_box( col, row, { :text => @converter.iconv( item ),
                                 :width => (@card_width / output_row.size),
                                 :height => 26,
                                 :x => 0 + ((@card_width / output_row.size ) * index) ,
                                 :y => 0,
                                 :left_margin => 0,
                                 :top_margin => 0,
                                 :border_color => '#000',
                                 :border_size => 0,
                                 :align => :center,
                                 :font_size => 12 } )
    end

    output_row = [ event.day,
                   event.room,
                   event.start_time ? event.start_time.strftime('%H:%M') : '',
                   event.duration.strftime('%H:%M') ]

    output_row.each_with_index do | item, index |
      draw_text_box( col, row, { :text =>item,
                                 :width => (@card_width / output_row.size),
                                 :height => 42,
                                 :x => 0 + ((@card_width / output_row.size ) * index) ,
                                 :y => 43,
                                 :left_margin => 0,
                                 :top_margin => 0.4,
                                 :border_size => 1,
                                 :border_color => '#ababab',
                                 :text_color => '#ababab',
                                 :align => :center,
                                 :font_size => 18})
    end

    # Draw Persons box
    persons = View_event_person.select({:event_id => event.event_id, :translated => @language_id})

    speakers, moderators, coordinators = [], [], []
    persons.each do |person|
      speakers << "<b>#{person.event_role_name}</b>: #{person.name}\n" if person.event_role == 'speaker'
      moderators << "<b>#{person.event_role_name}</b>: #{person.name}\n" if person.event_role == 'moderator'
      coordinators << "<b>#{person.event_role_name}</b>: #{person.name}\n" if person.event_role == 'coordinator'
    end

    persons = speakers + moderators + coordinators

    draw_text_box( col, row, { :text => persons.join(''),
                               :width => 130,
                               :height => 70,
                               :x => 0,
                               :y =>88,
                               :left_margin => 0.2,
                               :top_margin => 0,
                               :border_size => 0,
                               :align => :left,
                               :font_size => 10 } )

    draw_text_box( col, row, { :text => event.abstract,
                               :width => 236,
                               :height => 83,
                               :x => 131,
                               :y => 91,
                               :bgcolor => '#fff',
                               :left_margin => 0.2,
                               :top_margin => 0.3,
                               :border_color => '#00f',
                               :border_size => 0,
                               :align => :left,
                               :font_size => 9 } )

    draw_text_box( col, row, { :text => event.subtitle,
                               :width => 296,
                               :height => 37,
                               :x => 70,
                               :y => @card_height - 34 - 36 - 4,
                               :left_margin => 0.2,
                               :top_margin => 0,
                               :border_size => 0,
                               :align => :left,
                               :font_size => 15})

    # title in the top
    draw_text_box( col, row, { :text => "<b>#{event.title}</b>",
                               :width => 225,
                               :height => 36,
                               :x => 70,
                               :y => @card_height - 32 ,
                               :left_margin => 0.2,
                               :top_margin => 0.1,
                               :border_size => 0,
                               :align => :left,
                               :font_size => 18})

    # event_id top right corner
    draw_text_box( col, row, { :text => "<b>#{event.event_id}</b>",
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
                               :font_size => 21 } )

    # FIXME should be defined some reasonable place not hardcoded:
    $site_url = "cccv.pentabarf.org"
    # insert image
    begin
      # pdf-writer does not like png tranparency
      event_image = View_event_image.select( {:event_id => event.event_id } ).image
      add_image( col, row, event_image, 5, @card_height - 50, 60, 60, "http://#{$site_url}/pentabarf/event/#{event.event_id}" )
    rescue
    end

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
    valign = args[:valign] || 'top'

    # set colors or set to default colorset:
    text_color =  args[:text_color]  || '#000'

    if args[:bgcolor] then
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
    # inner margins in centimeter
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

    render_text( {:text => text,
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

