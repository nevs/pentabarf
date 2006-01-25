
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
          begin
            value = YAML.load(value.gsub('HashWithIndifferentAccess', 'Hash'))
          rescue => e
            begin
              Momomoto::Base.log_error("Exception while reading YAML: #{value.inspect}\n#{e}")
            rescue
            end
            value = {}
          end
        else
          value = Hash.new
        end
        # make sure certain values are set
        value[:current_conference_id] = 1 unless value[:current_conference_id].to_i > 0 
        value[:current_language_id] = 120 unless value[:current_language_id].to_i > 0
        value[:search_event] = "" unless value[:search_event]
        value[:search_event_page] = 0 unless value[:search_event_page] && value[:search_event_page] > 0
        value[:search_event_advanced] = {} unless value[:search_event_advanced]
        value[:search_event_advanced_page] = 0 unless value[:search_event_advanced_page] && value[:search_event_advanced_page] > 0
        value[:search_event_type] = 'simple' unless value[:search_event_type]
        value[:saved_event_search] = {} unless value[:saved_event_search].class == Hash
        value[:search_person] = "" unless value[:search_person]
        value[:search_person_page] = 0 unless value[:search_person_page] && value[:search_person_page] > 0
        value[:search_person_advanced] = {} unless value[:search_person_advanced]
        value[:search_person_advanced_page] = 0 unless value[:search_person_advanced_page] && value[:search_person_advanced_page] > 0
        value[:saved_person_search] = {} unless value[:saved_person_search].class == Hash
        value[:search_person_type] = 'simple' unless value[:search_person_type]
        value[:search_conference] = "" unless value[:search_conference]
        value[:search_conference_page] = 0 unless value[:search_conference_page] && value[:search_conference_page] > 0
        value[:search_conference_advanced] = {} unless value[:search_conference_advanced]
        value[:search_conference_advanced_page] = 0 unless value[:search_conference_advanced_page] && value[:search_conference_advanced_page] > 0
        value[:search_conference_type] = 'simple' unless value[:search_conference_type]
        value[:hits_per_page] = 42 unless value[:hits_per_page].to_i > 0
        value
      end

      def scrub_preferences( value )
        if value.kind_of?(Hash)
          clean_hash = Hash.new
          value.each do | key, value |
            clean_hash[ scrub_preferences(key.to_s).to_sym ] = scrub_preferences( value )
          end
          return clean_hash
        elsif value.kind_of?(String)
          return value.gsub("'",'').gsub('"','').gsub("\\",'')
        elsif value.kind_of?(Symbol)
          return value.to_s.gsub("'",'').gsub('"','').gsub("\\",'').to_sym
        elsif value.kind_of?(Integer) || value.kind_of?(Fixnum)
          return value
        elsif value.nil?
          return nil
        else
          raise "Unsupported Object in Preferences: #{value.class}\n#{value.inspect}"
        end
      end

      def filter_write( value )
        value = scrub_preferences( value )
        if value != nil
          value = YAML.dump( value ).gsub('HashWithIndifferentAccess', 'Hash')
          value = value.gsub(/'/, "")
          value = value.gsub('"\"', '"')
          value = value.gsub("\\", "\\\\\\\\")
          return "'#{value}'"
        end
        return "NULL"
      end

    end

  end
end

