
module Momomoto
  module Datatype

    class Base

      protected

        @value = nil
        @dirty = false

        @properties = {}

      public

      # has this field been modified
      def dirty?
        if property(:auto_update)
          return true
        else
          return @dirty
        end
      end

      # default value for new fields of this type
      def new_value
        nil
      end

      # get a property
      def property( name )
        @properties[name]
      end

      # get the value
      def value
        filter_get(@value).clone if @value
      end

      # prepare value for writing into database
      def write_value
        filter_write(@value)
      end

      # assign a value to this field
      def value=( new_value )
        new_value = filter_set( new_value )
        @dirty = true unless @value == new_value
        @value = new_value
      end

      # filter function applied to data coming from the database
      def import( value )
        @value = filter_read( value )
        @dirty = false
      end

      def initialize( properties = {} )
        @properties = properties
      end

      # this filter is applied before writing to the database to escape data properly
      def filter_write( data )
        return 'NULL' unless data
        data = data.gsub( /\\/, '' )
        "'" + PGconn.escape( data ) + "'"
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

