module Momomoto
  class View_event_state_combined < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :event_state_progress_id => Datatype::Integer.new( {} ),
        :event_state_id => Datatype::Integer.new( {} ),
        :event_state_progress_tag => Datatype::Varchar.new( {:length=>32} ),
        :language_id => Datatype::Integer.new( {} ),
        :event_state_tag => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Text.new( {} )
      }
    end
  end
end
