class View_conference_language < Momomoto::Table

  module Methods

    def current_transaction_id
      log_entry = Log::Conference_language.select_single({:conference_id=>get_column(:conference_id),:language=>get_column(:language)},{:order=>Momomoto::desc(:log_transaction_id),:limit=>1})
      return log_entry.log_transaction_id
     rescue Momomoto::Nothing_found
      0
    end

  end

end

