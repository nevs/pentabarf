module Momomoto
  class View_arrived < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :f_arrived => Datatype::Bool.new( {} )
      }
    end
  end
end
