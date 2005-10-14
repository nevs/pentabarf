
module Momomoto 
  module Datatype

    class Base
    
      protected

        @value = nil
        @dirty = false

        @properties = {}
  
      public

      def dirty?
        if property(:auto_update)
          return true
        else
          return @dirty
        end
      end

      def new_value
        nil
      end

      def property( name )
        @properties[name]
      end

      def value()
        filter_get(@value).clone if @value
      end

      def write_value()
        filter_write(@value)
      end

      def value=( new_value )
        new_value = filter_set( new_value )
        @dirty = true unless @value == new_value
        @value = new_value
      end

      def import( value )
        @value = filter_read( value )
        @dirty = false
      end

      def initialize( properties = {} )
        @properties = properties
      end

      # this filter is applied before writing to the database to escape data properly
      def filter_write( data )
        return 'NULL' if data == nil
        data = data.gsub( /\\/, '' )
        data = data.gsub( /'/, "''" )
        "'" + data + "'"
      end
  
      protected
  
      # this filter is applied when trying to get a value of this datatype
      def filter_get( data )
        data
      end

      # this filter is applied when trying to set a value of this datatype
      def filter_set( data )
        return nil if data == ''
        data.gsub( /\\/, '' ) unless data == nil
      end
      
      # this filter is applied after reading from the database
      def filter_read( data )
        data
      end
  
    end
    
  end
end

