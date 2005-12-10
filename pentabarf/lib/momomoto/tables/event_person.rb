module Momomoto
  class Event_person < Base
    def initialize
      super
      @domain = 'event'
      @log_changes = true
      @fields = {
        :event_person_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :event_id => Datatype::Integer.new( {:not_null=>true} ),
        :person_id => Datatype::Integer.new( {:not_null=>true} ),
        :event_role_id => Datatype::Integer.new( {:not_null=>true} ),
        :event_role_state_id => Datatype::Integer.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :rank => Datatype::Integer.new( {} ),
        :last_modified => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true, :auto_update=>true} ),
        :last_modified_by => Datatype::Integer.new( {} )
      }
    end
  end
end
