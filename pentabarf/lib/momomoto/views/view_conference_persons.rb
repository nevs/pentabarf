module Momomoto
  class View_conference_persons < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :event_role_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_role => Datatype::Varchar.new( {} ),
        :translated_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} )
      }
    end
  end
end
