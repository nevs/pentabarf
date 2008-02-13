require 'yaml'
class Account_settings < Momomoto::Table
  schema_name "auth"
  module Methods

    def current_conference_id
      get_column(:current_conference_id) || 1
    end

    def current_language
      get_column(:current_language) || 'en'
    end

    def preferences
      YAML.load( get_column( :preferences ) ) rescue {}
    end

    def preferences=( value )
      set_column( :preferences, value.to_yaml )
    end

  end
end

