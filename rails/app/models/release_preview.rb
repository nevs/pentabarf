
module Release_preview
  class Conference < Momomoto::Table

    fk_helper_multiple :events, View_schedule_event, [:conference_id]
    fk_helper_multiple :persons, View_schedule_person, [:conference_id]
    fk_helper_multiple :days, View_schedule_day, [:conference_id]
    fk_helper_multiple :rooms, View_schedule_room, [:conference_id]
    fk_helper_multiple :tracks, View_schedule_track, [:conference_id]

    module Methods

      def release
        Conference_release.new({:conference_release=>'PREVIEW'})
      end

    end

  end
end
