module Momomoto
  class View_report_feedback < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>256} ),
        :votes => Datatype::Integer.new( {} ),
        :comments => Datatype::Integer.new( {} ),
        :participant_knowledge => Datatype::Integer.new( {} ),
        :topic_importance => Datatype::Integer.new( {} ),
        :content_quality => Datatype::Integer.new( {} ),
        :presentation_quality => Datatype::Integer.new( {} ),
        :audience_involvement => Datatype::Integer.new( {} )
      }
    end
  end
end
