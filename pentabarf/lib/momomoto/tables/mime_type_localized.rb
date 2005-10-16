module Momomoto
  class Mime_type_localized < Base
    def initialize
      super
      @domain = 'localization'
      @fields = {
        :mime_type_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :language_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :name => Datatype::Varchar.new( {:not_null=>true, :length=>128} )
      }
    end
  end
end
