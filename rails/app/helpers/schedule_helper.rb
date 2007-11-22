require 'bluecloth'

module ScheduleHelper

  def sanitize_track( track )
    track = track.to_s.downcase.gsub(/[^a-z0-9]/, '')
    return track == '' ? '' : h("track-#{track}")
  end

  # returns an array with the names of rooms that are really used in a schedule table
  def schedule_rooms( table, rooms )
    used_rooms = []
    rooms.each do | room |
      table.each do | row |
        if row[room.conference_room]
          used_rooms.push( room.conference_room)
          break
        end
      end
    end
    used_rooms
  end

  def person_image( person_id = 0, size = 32, extension = 'png' )
    image = Person_image.select({:person_id=>person_id},{:columns=>[:public]}).first
    person_id = 0 if !image || !image.public
    url_for({:controller=>'image',:action=>:person,:id=>person_id,:size=>"#{size}x#{size}",:extension=>extension})
  end

  def event_image( event_id = 0, size = 32, extension = 'png' )
    url_for({:controller=>'image',:action=>:event,:id=>event_id,:size=>"#{size}x#{size}",:extension=>extension})
  end

  def conference_image( conference_id = 0, size = 32, extension = 'png' )
    url_for({:controller=>'image',:action=>:conference,:id=>conference_id,:size=>"#{size}x#{size}",:extension=>extension})
  end

end
