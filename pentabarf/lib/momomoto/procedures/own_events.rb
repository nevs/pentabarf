module Momomoto
  class Own_events < Base
    def initialize
      super
      @domain = 'public'
      @query = "SELECT own_events AS event_id,
                       %person_id% AS person_id,
                       %conference_id% AS conference_id
                  FROM own_events(%person_id%, %conference_id%)"
      @fields = {
        :person_id          => Datatype::Integer.new({:parameter=>true}),
        :conference_id      => Datatype::Integer.new({:parameter=>true}),
        :event_id           => Datatype::Integer.new({})
      }
    end
  end
end

