
require 'datatype/base'

module Momomoto 
  module Datatype

    class Preferences < Base 

      def filter_set( value )
        value
      end

      def filter_get( value )
        value
      end

      def filter_read( value )
        if value.to_s != ''
          value = Marshal.load(value)
        else
          value = Hash.new
        end
        # make sure certain values are set
        value[:current_conference_id] = 7 unless value[:current_conference_id]
        value[:current_language_id] = 120 unless value[:current_language_id]
        value[:search_event] = '' unless value[:search_event]
        value[:search_event_advanced] = {} unless value[:search_event_advanced]
        value
      end

      def filter_write( value )
        if value != nil
          value = Marshal.dump( value )
          value = value.gsub(/'/, "''").gsub(/\\/, "\\\\")
          return "'#{value}'"
        end
        return "NULL"
      end
 
    end
 
  end
end

