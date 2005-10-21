module Momomoto
  class View_event_rating_public < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :participant_knowledge => Datatype::Smallint.new( {} ),
        :topic_importance => Datatype::Smallint.new( {} ),
        :content_quality => Datatype::Smallint.new( {} ),
        :presentation_quality => Datatype::Smallint.new( {} ),
        :audience_involvement => Datatype::Smallint.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :eval_time => Datatype::Timestamp.new( {:with_timezone=>true} ),
        :rater_ip => Datatype::Inet.new( {} )
      }
    end
  end
end
