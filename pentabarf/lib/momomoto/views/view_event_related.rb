module Momomoto
  class View_event_related < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_id1 => Datatype::Integer.new( {} ),
        :event_id => Datatype::Integer.new( {} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>128} )
      }
    end
  end
end
