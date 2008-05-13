
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
        if change.respond_to?(:conference_id)
          {:controller=>'pentabarf',:action=>:conference,:id=>change.conference_id}
        elsif change.respond_to?(:event_id)
          {:controller=>'pentabarf',:action=>:event,:id=>change.event_id}
        elsif change.respond_to?(:person_id)
          {:controller=>'pentabarf',:action=>:person,:id=>change.person_id}
        elsif change.class.table.table_name.match(/_localized$/)
          {:controller=>'localization',:action=>change.class.table.table_name.gsub(/_localized$/,'')}
        else
          {}
        end
      end

    end

  end

end
