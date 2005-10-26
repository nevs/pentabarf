require 'datatype/base'

module Momomoto 
  module Datatype
    class Textsearch < Base 

      def filter_write( data = '')
        data = {:eq => [data]} if data.kind_of?(String) || data.kind_of?(Integer)
        data = {:eq => data} if data.kind_of?(Array)
        cond = ''
        data.each do | op, values |
          operation = case op.to_sym when :eq then 'ILIKE' 
                                     when :ne then 'NOT ILIKE' 
                                     else raise "Unsupported operator #{op} in keysearch" 
                                     end
          values.each do | val |
            fields = property(:field).collect do | field_name |
              "#{field_name} #{operation} '%#{val.to_s.gsub(/[%\\']/, '')}%'"
            end
            cond += ' AND ' if cond != ''
            cond += '(' + fields.join(' OR ') + ')'
          end
        end
        cond
      end

    end
  end
end
