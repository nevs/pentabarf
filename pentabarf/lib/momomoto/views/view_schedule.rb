module Momomoto
  class View_schedule < Base
    def initialize
      super
      @domain = 'event'
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
        :language_id => Datatype::Integer.new( {} ),
        :room_id => Datatype::Integer.new( {} ),
        :day => Datatype::Smallint.new( {} ),
        :start_time => Datatype::Interval.new( {} ),
        :abstract => Datatype::Text.new( {} ),
        :description => Datatype::Text.new( {} ),
        :f_public => Datatype::Bool.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} ),
        :language => Datatype::Varchar.new( {} ),
        :translated_id => Datatype::Integer.new( {} ),
        :translated_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state => Datatype::Varchar.new( {} ),
        :event_state_progress_id => Datatype::Integer.new( {} ),
        :event_state_progress_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state_progress => Datatype::Varchar.new( {} ),
        :event_type_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_type => Datatype::Varchar.new( {} ),
        :conference_track_tag => Datatype::Varchar.new( {:length=>32} ),
        :conference_track => Datatype::Varchar.new( {} ),
        :start_datetime => Datatype::Timestamp.new( {} ),
        :real_starttime => Datatype::Time.new( {} )
      }
    end
  end
end
