module Momomoto
  class Event_role_localized < Base
    def initialize
      super
      @domain = 'localization'
      @fields = {
        :event_role_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :language_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :name => Datatype::Varchar.new( {:length=>64} )
      }
    end
  end
end
