
module Momomoto

  class Row

    # returns the current log_transaction_id of the current record
    def current_transaction_id
      table = self.class.table
      begin
        log_table = "Log::#{self.class.table.table_name.capitalize}".constantize
      rescue
        raise "Log table not found."
      end
      constraints = {}
      table.primary_keys.each do | key |
        constraints[key] = get_column( key )
      end
      begin
        log_entry = log_table.select_single( constraints, {:order=>Momomoto::desc(:log_transaction_id),:limit=>1})
        return log_entry.log_transaction_id
      rescue Momomoto::Nothing_found
        # return 0 as transaction_id if no log record has been found
        return 0
      end
    end

  end

end
