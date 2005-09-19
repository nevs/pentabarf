require 'datatype/base'

module Momomoto 
  module Datatype
    class Textsearch < Base 

      def filter_write( data = '')
        cond = ''
        if data.kind_of?(Array)
          data.each do | v |
            cond += ' AND ' unless cond == ''
            cond += filter_write( v )
          end
        else
          fields = ''
          property(:field).each do | field_name |
            fields += ' OR ' unless fields == ''
            fields += "#{field_name} ILIKE '%#{data.to_s.gsub(/[%\\']/, '')}%'"
          end
          cond = '(' + fields + ')'
        end
        cond
      end
  
    end
  end
end
