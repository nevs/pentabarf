class View_event_person < Momomoto::Table

  module Methods

    def current_transaction_id
      log_entry = Log::Event_person.select_single({:event_person_id=>get_column(:event_person_id)},{:order=>Momomoto::desc(:log_transaction_id),:limit=>1})
      return log_entry.log_transaction_id
     rescue Momomoto::Nothing_found
      0
    end

  end

end

