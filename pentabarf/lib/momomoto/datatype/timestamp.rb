
require 'datatype/base'

module Momomoto 
  module Datatype

    class Timestamp < Base 

      def write_value()
        if property(:auto_update)
          return 'now()'
        else
          return super
        end
      end
 
    end
    
  end
end

