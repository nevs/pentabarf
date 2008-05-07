
module Momomoto

  class Table

    class << self

      def log_content_columns
        columns.keys
      end

      def log_hidden_columns
        []
      end

      def log_change_title( change )
        ""
      end

      def log_change_url( change )
        {}
      end

    end

  end

end
