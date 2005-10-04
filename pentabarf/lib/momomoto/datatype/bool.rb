
require 'datatype/base'

module Momomoto 
  module Datatype

    class Bool < Base 
      def filter_set( value )
        case value
          when 't', '1', 1, true 
            then 't'
          when nil
            then property(:not_null) ? 'f' : nil
          else 
            'f'
        end
      end

    end
    
  end
end

