require 'datatype/base'

module Momomoto 
  module Datatype
    class Boolsearch < Base 

      def filter_write( data = '')
        data = Array.new.push( data ) unless data.kind_of?( Array )
        sql = ''
        data.each do | value |
          if value == 't'
            cond = "#{property(:field)} = 't'"
          elsif value == 'f'
            cond = "#{property(:field)} = 'f'"
          else
            cond = "#{property(:field)} IS NULL"
          end
          sql += sql != '' ? ' AND ' + cond : cond
        end
        sql
      end
  
    end
  end
end
