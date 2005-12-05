module Momomoto
  class Event_attachment < Base
    def initialize
      super
      @domain = 'event'
      @log_changes = true
      @fields = {
        :event_attachment_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :attachment_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :event_id => Datatype::Integer.new( {:not_null=>true} ),
        :mime_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :filename => Datatype::Varchar.new( {:length=>256} ),
        :data => Datatype::Bytea.new( {:not_null=>true} ),
        :f_public => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :title => Datatype::Varchar.new( {:length=>256} ),
        :pages => Datatype::Integer.new( {} ),
        :last_modified => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true, :auto_update=>true} ),
        :last_modified_by => Datatype::Integer.new( {} )
      }
    end
  end
end
