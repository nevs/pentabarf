module Momomoto
  class Person_link < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_link_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :person_id => Datatype::Integer.new( {:not_null=>true} ),
        :link_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :url => Datatype::Varchar.new( {:not_null=>true, :length=>1024} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :description => Datatype::Varchar.new( {:length=>128} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
