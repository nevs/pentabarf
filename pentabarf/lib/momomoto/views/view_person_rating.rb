module Momomoto
  class View_person_rating < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :evaluator_id => Datatype::Integer.new( {} ),
        :speaker_quality => Datatype::Smallint.new( {} ),
        :competence => Datatype::Smallint.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :eval_time => Datatype::Timestamp.new( {:with_timezone=>true} ),
        :name => Datatype::Varchar.new( {} )
      }
    end
  end
end
