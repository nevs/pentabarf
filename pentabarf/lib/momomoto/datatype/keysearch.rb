require 'datatype/base'

module Momomoto 
  module Datatype
    class Keysearch < Base 

      def filter_write( data = '')
        data = {:eq => [data]} if data.kind_of?(String) || data.kind_of?(Integer)
        data = {:eq => data} if data.kind_of?(Array)
        fields = []
        data.each do | op, values |
          values.collect! do | val | "'#{val.to_i}'" end
          cond = property(:subselect).gsub( /%%%/, values.join( ', ') )
          operation = case op.to_sym when :eq then 'IN' 
                                     when :ne then 'NOT IN' 
                                     else raise "Unsupported operator #{op} in keysearch" 
                                     end
          fields.push("#{property(:key_field)} #{operation} (#{cond})")
        end
        fields.join(" AND ")
      end
  
    end
  end
end
