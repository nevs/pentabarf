module Momomoto
  class View_event_link_internal < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_link_internal_id => Datatype::Integer.new( {} ),
        :event_id => Datatype::Integer.new( {} ),
        :link_type_id => Datatype::Integer.new( {} ),
        :url => Datatype::Varchar.new( {:length=>1024} ),
        :description => Datatype::Varchar.new( {:length=>256} ),
        :rank => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :template => Datatype::Varchar.new( {:length=>1024} ),
        :tag => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Varchar.new( {} )
      }
    end
  end
end
