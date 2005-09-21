module Momomoto
  class View_event_rating < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_id => Datatype::Integer.new( {} ),
        :person_id => Datatype::Integer.new( {} ),
        :relevance => Datatype::Smallint.new( {} ),
        :actuality => Datatype::Smallint.new( {} ),
        :acceptance => Datatype::Smallint.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :eval_time => Datatype::Timestamp.new( {:with_timezone=>true} ),
        :name => Datatype::Varchar.new( {} )
      }
    end
  end
end
