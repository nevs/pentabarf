
require 'datatype/base'

module Momomoto
  module Datatype

    class Bool < Base

      def value
        filter_get(@value)
      end

      # filter function applied to data coming from the database
      def import( value )
        @value = filter_set( value )
        @dirty = false
      end

      def filter_set( value )
        if property(:not_null)
          case value
            when 't', '1', 1, true, 'true'
              then true
            else
              false
          end
        else
          case value
            when 't', '1', 1, true, 'true'
              then true
            when 'f', '0', 0, false, 'false'
              then false
            else
              nil
          end
        end
      end

      def filter_write( value )
        case value
          when 't', true, 1
            then "'t'"
          when 'f', false, 0
            then "'f'"
          else
            'NULL'
        end
      end

    end
    
  end
end

