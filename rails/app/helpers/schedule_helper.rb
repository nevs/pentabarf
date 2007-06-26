module ScheduleHelper

  def sanitize_track( track )
    track = track.to_s.downcase.gsub(/[^a-z0-9]/, '')
    return track == '' ? '' : h("track-#{track}")
  end

  # returns an array with the ids of rooms that are really used in a schedule table
  def schedule_rooms( table, rooms )
    used_rooms = []
    rooms.each do | room |
      table.each do | row |
        if row[room.room_id]
          used_rooms.push( room.room_id)
          break
        end
      end
    end
    used_rooms
  end
            
end
