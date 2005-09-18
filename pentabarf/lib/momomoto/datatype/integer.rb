
require 'datatype/base'

module Momomoto 
  module Datatype

    class Integer < Base 

      def value()
        filter_get(@value) if @value
      end

      def filter_set( value )
        value.to_i if value
      end

      def filter_get( value )
        value.to_i if value
      end

      def filter_read( value )
        value
      end
    
      def filter_write( value )
        value.to_i != 0 ? "'" + value.to_i.to_s + "'" : "NULL"
      end

    end
    
  end
end

