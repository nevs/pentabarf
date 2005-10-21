
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
        begin
          return ::Time.parse( value )
        rescue
          return nil
        end
      end

      def filter_set( value )
        begin
          if value.kind_of?( String ) && value.length > 0
            return ::Time.parse( value )
          elsif value.kind_of?( ::Time )
            return value
          end
        rescue
        end
        return nil
      end

    end
    
  end
end

