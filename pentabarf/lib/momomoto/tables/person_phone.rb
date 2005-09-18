module Momomoto
  class Person_phone < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_phone_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true, :serial=>true} ),
        :person_id => Datatype::Integer.new( {:not_null=>true} ),
        :phone_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :phone_number => Datatype::Varchar.new( {:not_null=>true, :length=>32} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
