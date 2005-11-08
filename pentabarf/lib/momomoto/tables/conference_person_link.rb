module Momomoto
  class Conference_person_link < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :conference_person_link_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :conference_person_id => Datatype::Integer.new( {:not_null=>true} ),
        :url => Datatype::Text.new( {:not_null=>true} ),
        :title => Datatype::Varchar.new( {:length=>256} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
