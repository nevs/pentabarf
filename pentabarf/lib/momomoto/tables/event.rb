module Momomoto
  class Event < Base
    def initialize
      super
      @domain = 'event'
      @order = 'lower(title), lower(subtitle)'
      @log_changes = true
      @fields = {
        :event_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :conference_id => Datatype::Integer.new( {:not_null=>true} ),
        :tag => Datatype::Varchar.new( {:length=>256} ),
        :title => Datatype::Varchar.new( {:not_null=>true, :length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>256} ),
        :conference_track_id => Datatype::Integer.new( {} ),
        :team_id => Datatype::Integer.new( {} ),
        :event_type_id => Datatype::Integer.new( {} ),
        :duration => Datatype::Interval.new( {} ),
        :event_state_id => Datatype::Integer.new( {:not_null=>true} ),
        :language_id => Datatype::Integer.new( {} ),
        :room_id => Datatype::Integer.new( {} ),
        :day => Datatype::Smallint.new( {} ),
        :start_time => Datatype::Interval.new( {} ),
        :abstract => Datatype::Text.new( {} ),
        :description => Datatype::Text.new( {} ),
        :resources => Datatype::Text.new( {} ),
        :f_public => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_paper => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_slides => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_conflict => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_deleted => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :remark => Datatype::Text.new( {} ),
        :event_origin_id => Datatype::Integer.new( {:not_null=>true} ),
        :f_unmoderated => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :event_state_progress_id => Datatype::Integer.new( {:not_null=>true} ),
        :last_modified => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true, :auto_update=>true} )
      }
    end
  end
end
