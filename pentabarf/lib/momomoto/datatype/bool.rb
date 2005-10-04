
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

    end
    
  end
end

