require 'datatype/base'

module Momomoto 
  module Datatype
    class Boolsearch < Base 

      def filter_write( data = '')
        data = {:eq => [data]} if data.kind_of?(String) || data.kind_of?(Integer)
        data = {:eq => data} if data.kind_of?(Array)
        fields = []
        data.each do | op, values |
          if op.to_sym == :ne
            cond = []
            values.each do | val |
              cond.push(case val when 't',true,1 then "#{property(:field)} <> 't'"
                                 when 'f',false,0 then "#{property(:field)} <> 'f'"
                                 else "#{property(:field)} IS NOT NULL" end )
            end
            fields.push( cond.join(" AND "))
          else
            cond = []
            values.each do | val |
              cond.push(case val when 't',true,1 then "#{property(:field)} = 't'"
                                 when 'f',false,0 then "#{property(:field)} = 'f'"
                                 else "#{property(:field)} IS NULL" end )
            end
            fields.push( "(" + cond.join(" OR ") + ")" )
          end
        end
        fields.join(" AND ")
      end
  
    end
  end
end
