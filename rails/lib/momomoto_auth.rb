
module Momomoto

  class Table

    class << self

      alias_method( :__select, :select )

      def select( *args )
        results = __select( *args )
        return POPE.table_select( self, results )
      end


      alias_method( :__write, :write )

      def write( *args )
        if args[0].dirty?
          POPE.table_write( self, *args )
          return __write( *args )
        end
        false
      end

      alias_method( :__delete, :delete )

      def delete( *args )
        POPE.table_delete( self, *args )
        __delete( *args )
      end

    end

  end

end
