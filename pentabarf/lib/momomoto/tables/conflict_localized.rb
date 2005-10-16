module Momomoto
  class Conflict_localized < Base
    def initialize
      super
      @domain = 'localization'
      @fields = {
        :conflict_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :language_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :name => Datatype::Text.new( {:not_null=>true} )
      }
    end
  end
end
