module Momomoto
  class Event_origin_localized < Base
    def initialize
      super
      @domain = 'localization'
      @fields = {
        :event_origin_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :language_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :name => Datatype::Varchar.new( {:length=>64, :not_null=>true} )
      }
    end
  end
end
