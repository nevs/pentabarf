module Momomoto
  class View_event_rating < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_id => Datatype::Integer.new( {} ),
        :person_id => Datatype::Integer.new( {} ),
        :relevance => Datatype::Smallint.new( {} ),
        :relevance_comment => Datatype::Varchar.new( {:length=>128} ),
        :actuality => Datatype::Smallint.new( {} ),
        :actuality_comment => Datatype::Varchar.new( {:length=>128} ),
        :acceptance => Datatype::Smallint.new( {} ),
        :acceptance_comment => Datatype::Varchar.new( {:length=>128} ),
        :remark => Datatype::Text.new( {} ),
        :eval_time => Datatype::Timestamp.new( {:with_timezone=>true} ),
        :name => Datatype::Varchar.new( {} )
      }
    end
  end
end
