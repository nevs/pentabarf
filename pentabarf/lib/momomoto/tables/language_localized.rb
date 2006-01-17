module Momomoto
  class Language_localized < Base
    def initialize
      super
      @domain = 'localization'
      @fields = {
        :language_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :translated_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :name => Datatype::Varchar.new( {:length=>64, :not_null=>true} )
      }
    end
  end
end
