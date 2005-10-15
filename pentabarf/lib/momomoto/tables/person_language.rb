module Momomoto
  class Person_language < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :language_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
