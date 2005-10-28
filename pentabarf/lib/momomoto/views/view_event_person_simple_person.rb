module Momomoto
  class View_event_person_simple_person < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :event_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :event_role_id => Datatype::Integer.new( {} ),
        :event_role_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_role_state_id => Datatype::Integer.new( {} ),
        :event_role_state_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
