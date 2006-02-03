module Momomoto
  class Event_link < Base
    def initialize
      super
      @domain = 'event'
      @log_changes = true
      @fields = {
        :event_link_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :event_id => Datatype::Integer.new( {:not_null=>true} ),
        :url => Datatype::Varchar.new( {:length=>1024, :not_null=>true} ),
        :rank => Datatype::Integer.new( {} ),
        :title => Datatype::Varchar.new( {:length=>256} ),
        :last_modified => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true, :auto_update=>true} ),
        :last_modified_by => Datatype::Integer.new( {} )
      }
    end
  end
end
