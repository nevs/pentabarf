require 'datatype/base'

module Momomoto 
  module Datatype
    class Textsearch < Base 

      def filter_write( data )
        cond = ''
        data.to_s.split( ' ' ).each do | value |
          fields = ''
          property(:field).each do | field_name |
            fields += fields != '' ? ' OR ' : ''
            fields += "#{field_name} ILIKE '%#{value.to_s.gsub(/[%\\']/, '')}%'"
          end
          cond += cond != '' ? ' AND ' : ''
          cond += '(' + fields + ')'
        end
        cond
      end
  
    end
  end
end
