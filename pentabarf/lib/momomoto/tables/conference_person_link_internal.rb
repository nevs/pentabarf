module Momomoto
  class Conference_person_link_internal < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :conference_person_link_internal_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :conference_person_id => Datatype::Integer.new( {:not_null=>true} ),
        :link_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :url => Datatype::Text.new( {:not_null=>true} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :description => Datatype::Varchar.new( {:length=>128} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
