
module Momomoto

  class Table

    class << self

      alias_method( :__write, :write )

      def write( *args )
        return __write( *args ) if POPE.table_write( self, *args )
        raise Pope::PermissionError, "Not allowed to modify #{self.table_name}"
      end

      alias_method( :__delete, :delete )

      def delete( *args )
        return __delete( *args ) if POPE.table_delete( self, *args )
        raise Pope::PermissionError, "Not allowed to delete #{self.table_name}"
      end

    end

  end

end
