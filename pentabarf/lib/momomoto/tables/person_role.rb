module Momomoto
  class Person_role < Base
    def initialize
      super
      @domain = 'login'
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :role_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} )
      }
    end
  end
end
