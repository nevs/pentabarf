module Momomoto
  class Person_rating < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :evaluator_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :speaker_quality => Datatype::Smallint.new( {} ),
        :quality_comment => Datatype::Varchar.new( {:length=>128} ),
        :competence => Datatype::Smallint.new( {} ),
        :competence_comment => Datatype::Varchar.new( {:length=>128} ),
        :remark => Datatype::Text.new( {} ),
        :eval_time => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true} )
      }
    end
  end
end
