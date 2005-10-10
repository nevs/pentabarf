module Momomoto
  class Person_rating < Base
    def initialize
      super
      @domain = 'rating'
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :evaluator_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :speaker_quality => Datatype::Smallint.new( {} ),
        :competence => Datatype::Smallint.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :eval_time => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true} )
      }
    end
  end
end
