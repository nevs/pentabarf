module Momomoto
  class Activate_account < Base
    def initialize
      super
      @domain = 'public'
      @query = "SELECT activate_account AS person_id, 
                       %activation_string% AS activation_string
                  FROM activate_account(%activation_string%)"
      @fields = {
        :person_id          => Datatype::Integer.new({}),
        :activation_string  => Datatype::Char.new({:parameter=>true,:length=>64})
      }
    end
  end
end

