module Momomoto
  class View_event_search_persons < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :event_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
