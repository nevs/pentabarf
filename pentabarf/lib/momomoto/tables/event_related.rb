module Momomoto
  class Event_related < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_id1 => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :event_id2 => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} )
      }
    end
  end
end
