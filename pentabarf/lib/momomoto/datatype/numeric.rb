
require 'datatype/base'

module Momomoto 
  module Datatype

    class Numeric < Base

      def value()
        filter_get(@value) if @value
      end

      def filter_set( value )
        return nil if value == ''
        return value.to_f if value
      end

      def filter_get( value )
        value.to_f if value
      end

      def filter_read( value )
        value.to_f if value
      end
    
      def filter_write( value )
        value.to_f != 0.0 ? "'" + value.to_f.to_s + "'" : "NULL"
      end

    end
    
  end
end

