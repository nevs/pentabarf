module Momomoto
  class Own_events < Base
    def initialize
      super
      @domain = 'public'
      @query = "SELECT event_id,
                       %person_id% AS person_id
                  FROM (SELECT own_events AS event_id FROM own_events(%person_id%)) AS events"
      @fields = {
        :person_id          => Datatype::Integer.new({:parameter=>true}),
        :event_id           => Datatype::Integer.new({})
      }
    end
  end
end

