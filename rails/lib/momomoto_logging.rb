
module Momomoto

  class Table

    class << self

      def log_content_columns
        columns.keys - primary_keys
      end

      def log_hidden_columns
        []
      end

    end

  end

end
