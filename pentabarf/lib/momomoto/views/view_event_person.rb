module Momomoto
  class View_event_person < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_person_id => Datatype::Integer.new( {} ),
        :event_id => Datatype::Integer.new( {} ),
        :person_id => Datatype::Integer.new( {} ),
        :event_role_id => Datatype::Integer.new( {} ),
        :event_role_state_id => Datatype::Integer.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :rank => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>128} ),
        :event_state_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state => Datatype::Varchar.new( {} ),
        :event_role_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_role => Datatype::Varchar.new( {} ),
        :event_role_state_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_role_state => Datatype::Varchar.new( {} )
      }
    end
  end
end
