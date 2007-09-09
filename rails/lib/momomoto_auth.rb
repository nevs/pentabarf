
module Momomoto

  class Table

    class << self

      alias_method( :__write, :write )

      def write( *args )
        POPE.table_write( self, *args )
        __write( *args )
      end

      alias_method( :__delete, :delete )

      def delete( *args )
        POPE.table_delete( self, *args )
        __delete( *args )
      end

    end

  end

end
