
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
        begin
          return ::Date.parse( value )
        rescue
          return nil 
        end
      end

      def filter_set( value )
        begin
          if value.kind_of?( String ) && value.length > 0
            return ::Date.parse( value )
          elsif value.kind_of?( ::Date )
            return value
          end
        rescue
        end
        return nil
      end

    end
    
  end
end

