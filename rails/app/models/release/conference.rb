class Release::Conference < Momomoto::Table

  schema_name 'release'

  module Methods

    def days
      Release::Conference_day.select({:conference_id=>conference_id,:conference_release_id=>conference_release_id},:order=>:conference_day)
    end

    def rooms
      Release::Conference_room.select({:conference_id=>conference_id,:conference_release_id=>conference_release_id},:order=>[:rank,:conference_room])
    end

    def tracks
      Release::Conference_track.select({:conference_id=>conference_id,:conference_release_id=>conference_release_id},:order=>[:rank,:conference_track])
    end

  end

end
