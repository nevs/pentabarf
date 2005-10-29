module Momomoto
  class View_review < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>256} ),
        :event_state_id => Datatype::Integer.new( {} ),
        :event_state_progress_id => Datatype::Integer.new( {} ),
        :relevance => Datatype::Integer.new( {} ),
        :relevance_count => Datatype::Integer.new( {} ),
        :actuality => Datatype::Integer.new( {} ),
        :actuality_count => Datatype::Integer.new( {} ),
        :acceptance => Datatype::Integer.new( {} ),
        :acceptance_count => Datatype::Integer.new( {} ),
        :translated_id => Datatype::Integer.new( {} ),
        :event_state_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state => Datatype::Varchar.new( {} ),
        :event_state_progress_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state_progress => Datatype::Varchar.new( {} ),
        :conference_track_tag => Datatype::Varchar.new( {:length=>32} ),
        :conference_track => Datatype::Varchar.new( {} )
      }
    end
  end
end
