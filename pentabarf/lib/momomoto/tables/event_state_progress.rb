module Momomoto
  class Event_state_progress < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :event_state_progress_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :event_state_id => Datatype::Integer.new( {:not_null=>true} ),
        :tag => Datatype::Varchar.new( {:not_null=>true, :length=>32} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
