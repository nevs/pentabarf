
require 'datatype/base'

module Momomoto 
  module Datatype

    class Time < Base 

      def filter_write( data )
        return 'NULL' if data == nil
        "'" + data.strftime('%H:%M:%S') + "'"
      end

      def filter_read( value )
        return nil if value.nil?
        ::Time.parse( value )
      end

      def filter_set( value )
        if value.kind_of?( String ) && value.length > 0
          return ::Time.parse( value )
        elsif value.kind_of?( ::Time )
          return value
        else
          return nil
        end
      end

    end
    
  end
end

