class View_event_attachment < Momomoto::Table

  module Methods

    def current_transaction_id
      log_entry = Log::Event_attachment.select_single({:event_attachment_id=>get_column(:event_attachment_id)},{:order=>Momomoto::desc(:log_transaction_id),:limit=>1})
      return log_entry.log_transaction_id
     rescue Momomoto::Nothing_found
      0
    end

    def rooms( *args )
      conference_room( *args )
    end

    def tracks( *args )
      conference_track( *args )
    end

    def releases( *args )
      conference_release( *args )
    end

    def latest_release
      conference_release({}, {:limit=>1,:order=>Momomoto.desc(:conference_release_id)})[0]
    end

  end

end

