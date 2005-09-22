require 'datatype/base'

module Momomoto 
  module Datatype
    class Keysearch < Base 

      def filter_write( data = '')
        if data.kind_of?( Array )
          data.collect do | val |
            "'#{val.to_i}'"
          end
          fields = data.join(', ')
        else
          fields = "'#{data.to_i}'"
        end
        cond = property(:subselect).gsub( /%%%/, fields )
        "#{property(:key_field)} IN (#{cond})"
      end
  
    end
  end
end
