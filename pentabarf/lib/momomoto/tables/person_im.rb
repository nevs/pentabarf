module Momomoto
  class Person_im < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_im_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true, :serial=>true} ),
        :person_id => Datatype::Integer.new( {:not_null=>true} ),
        :im_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :im_address => Datatype::Varchar.new( {:not_null=>true, :length=>128} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
