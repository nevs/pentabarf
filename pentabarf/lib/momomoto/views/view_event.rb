module Momomoto
  class View_event < Base
    def initialize
      super
      @domain = 'event'
      @order = 'lower(view_event.title), lower(view_event.subtitle)'
      @fields = {
        :event_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>256} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>256} ),
        :conference_track_id => Datatype::Integer.new( {} ),
        :team_id => Datatype::Integer.new( {} ),
        :event_type_id => Datatype::Integer.new( {} ),
        :duration => Datatype::Interval.new( {} ),
        :event_state_id => Datatype::Integer.new( {} ),
        :event_state_progress_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :room_id => Datatype::Integer.new( {} ),
        :day => Datatype::Smallint.new( {} ),
        :start_time => Datatype::Interval.new( {} ),
        :abstract => Datatype::Text.new( {} ),
        :description => Datatype::Text.new( {} ),
        :resources => Datatype::Text.new( {} ),
        :f_public => Datatype::Bool.new( {} ),
        :f_paper => Datatype::Bool.new( {} ),
        :f_slides => Datatype::Bool.new( {} ),
        :f_conflict => Datatype::Bool.new( {} ),
        :f_deleted => Datatype::Bool.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :translated_id => Datatype::Integer.new( {} ),
        :translated_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state => Datatype::Varchar.new( {} ),
        :event_type_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_type => Datatype::Varchar.new( {} ),
        :conference_track_tag => Datatype::Varchar.new( {:length=>32} ),
        :conference_track => Datatype::Varchar.new( {} ),
        :team_tag => Datatype::Varchar.new( {:length=>32} ),
        :team => Datatype::Varchar.new( {} ),
        :room_tag => Datatype::Varchar.new( {:length=>32} ),
        :room => Datatype::Varchar.new( {} ),
        :acronym => Datatype::Varchar.new( {:length=>16} ),
        :start_datetime => Datatype::Datetime.new( {} ),
        :real_starttime => Datatype::Time.new( {} ),
        :mime_type_id => Datatype::Integer.new( {} ),
        :mime_type => Datatype::Varchar.new( {:length=>128} ),
        :file_extension => Datatype::Varchar.new( {:length=>16} )
      }
    end
  end
end
