
module Momomoto

  class Row

    # returns the current log_transaction_id of the current record
    def current_transaction_id
      table = self.class.table
      begin
        log_table = "Log::#{table.table_name.capitalize}".constantize
      rescue
        raise "Log table for table #{table.table_name} not found."
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

    # returns the log entry with a specific transaction_id
    def get_transaction_id( transaction_id )
      table = self.class.table
      begin
        log_table = "Log::#{table.table_name.capitalize}".constantize
      rescue
        raise "Log table for table #{table.table_name} not found."
      end
      constraints = {}
      table.primary_keys.each do | key |
        constraints[key] = get_column( key )
      end
      constraints[:log_transaction_id] = transaction_id
      log_entry = log_table.select_single( constraints, {:order=>Momomoto::desc(:log_transaction_id),:limit=>1})
      return log_entry
    end

  end

end
