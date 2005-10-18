
require 'datatype/base'

module Momomoto 
  module Datatype

    class Date < Base 

      def filter_write( data )
        return 'NULL' if data == nil
        "'" + data.strftime('%Y-%m-%d') + "'"
      end

      def filter_read( value )
        return nil if value.nil?
        ::Date.parse( value )
      end

      def filter_set( value )
        if value.kind_of?( String ) && value.length > 0
          return ::Date.parse( value )
        elsif value.kind_of?( ::Date )
          return value
        else
          return nil
        end
      end

    end
    
  end
end

