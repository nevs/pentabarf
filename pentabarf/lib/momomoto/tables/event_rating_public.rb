module Momomoto
  class Event_rating_public < Base
    def initialize
      super
      @domain = 'public'
      @fields = {
        :event_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :participant_knowledge => Datatype::Smallint.new( {} ),
        :topic_importance => Datatype::Smallint.new( {} ),
        :content_quality => Datatype::Smallint.new( {} ),
        :presentation_quality => Datatype::Smallint.new( {} ),
        :audience_involvement => Datatype::Smallint.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :eval_time => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true, :primary_key=>true} ),
        :rater_ip => Datatype::Inet.new( {} )
      }
    end
  end
end
