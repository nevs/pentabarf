module Momomoto
  class Event_link_internal < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_link_internal_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :event_id => Datatype::Integer.new( {:not_null=>true} ),
        :link_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :url => Datatype::Varchar.new( {:not_null=>true, :length=>1024} ),
        :description => Datatype::Varchar.new( {:length=>256} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
