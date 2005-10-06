
require 'datatype/base'

module Momomoto 
  module Datatype

    class Preferences < Base 

      def value()
        filter_get(@value).clone if @value
      end

      def new_value()
        {}
      end

      def value=( new_value )
        new_value = filter_set( new_value )
        @dirty = true unless new_value == @value
        @value = new_value
      end

      def filter_set( value )
        value
      end

      def filter_get( value )
        value
      end

      def filter_read( value )
        if value.to_s != ''
          value = YAML.load(value.gsub('HashWithIndifferentAccess', 'Hash'))
        else
          value = Hash.new
        end
        # make sure certain values are set
        value[:current_conference_id] = 1 unless value[:current_conference_id].to_i != 0
        value[:current_language_id] = 120 unless value[:current_language_id].to_i != 0
        value[:search_event] = "" unless value[:search_event]
        value[:search_event_advanced] = {} unless value[:search_event_advanced]
        value[:search_event_type] = 'simple' unless value[:search_event_type]
        value[:search_event_last] = 0 unless value[:search_event_last] && value[:search_event_last] > 0
        value[:search_person] = "" unless value[:search_person]
        value[:search_person_advanced] = {} unless value[:search_person_advanced]
        value[:search_person_type] = 'simple' unless value[:search_person_type]
        value[:search_person_last] = 0 unless value[:search_person_last] && value[:search_person_last] > 0
        value[:search_conference] = "" unless value[:search_conference]
        value[:search_conference_advanced] = {} unless value[:search_conference_advanced]
        value[:search_conference_type] = 'simple' unless value[:search_conference_type]
        value[:search_conference_last] = 0 unless value[:search_conference_last] && value[:search_conference_last] > 0
        value[:hits_per_page] = 42 unless value[:hits_per_page].to_i > 0
        value
      end

      def filter_write( value )
        if value != nil
          value = YAML.dump( value ).gsub('HashWithIndifferentAccess', 'Hash')
          value = value.gsub(/\\/, '').gsub(/'/, "''")
          return "'#{value}'"
        end
        return "NULL"
      end
 
    end
 
  end
end


