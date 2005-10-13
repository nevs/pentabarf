module Momomoto
  class Conference_phase_conflict < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :conference_phase_conflict_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :conference_phase_id => Datatype::Integer.new( {:not_null=>true} ),
        :conflict_id => Datatype::Integer.new( {:not_null=>true} ),
        :conflict_level_id => Datatype::Integer.new( {:not_null=>true} )
      }
    end
  end
end
