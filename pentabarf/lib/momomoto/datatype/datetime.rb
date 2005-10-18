
require 'datatype/base'

module Momomoto 
  module Datatype

    class Datetime < Base 

      def filter_write( data )
        return 'NULL' if data == nil
        "'" + data.strftime('%Y-%m-%d %H:%M:%S') + "'"
      end

      def filter_read( value )
        return nil if value.nil?
        ::DateTime.parse( value )
      end

      def filter_set( value )
        if value.kind_of?( String ) && value.length > 0
          return ::DateTime.parse( value )
        elsif value.kind_of?( ::DateTime )
          return value
        else
          return nil
        end
      end

    end
    
  end
end

