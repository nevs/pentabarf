module Momomoto
  class Conference_language < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :conference_language_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :conference_id => Datatype::Integer.new( {:not_null=>true} ),
        :language_id => Datatype::Integer.new( {:not_null=>true} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
