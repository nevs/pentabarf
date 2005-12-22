
require 'datatype/base'

module Momomoto 
  module Datatype

    class Bool < Base 
      def filter_set( value )
        if property(:not_null)
          case value
            when 't', '1', 1, true
              then 't'
            else
              'f'
          end
        else
          case value
            when 't', '1', 1, true 
              then 't'
            when 'f', '0', 0, false
              then 'f'
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

