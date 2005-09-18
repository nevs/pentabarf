module Momomoto
  class Event_rating < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :event_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :relevance => Datatype::Smallint.new( {} ),
        :relevance_comment => Datatype::Varchar.new( {:length=>128} ),
        :actuality => Datatype::Smallint.new( {} ),
        :actuality_comment => Datatype::Varchar.new( {:length=>128} ),
        :acceptance => Datatype::Smallint.new( {} ),
        :acceptance_comment => Datatype::Varchar.new( {:length=>128} ),
        :remark => Datatype::Text.new( {} ),
        :eval_time => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true} )
      }
    end
  end
end
