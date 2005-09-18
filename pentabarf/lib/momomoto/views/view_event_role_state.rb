module Momomoto
  class View_event_role_state < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :event_role_state_id => Datatype::Integer.new( {} ),
        :event_role_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Varchar.new( {} ),
        :rank => Datatype::Integer.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
