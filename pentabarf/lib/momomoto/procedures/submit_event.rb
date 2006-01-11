module Momomoto
  class Submit_event < Base
    def initialize
      super
      @domain = 'event'
      @query = "SELECT submit_event AS new_event_id,
                       %person_id% AS person_id,
                       %conference_id% AS conference_id,
                       %title% AS title
                  FROM submit_event( %person_id%, %conference_id%, %title%)"
      @fields = {
        :new_event_id   => Datatype::Integer.new({}),
        :person_id      => Datatype::Integer.new({:parameter=>true}),
        :conference_id  => Datatype::Integer.new({:parameter=>true}),
        :title          => Datatype::Text.new({:parameter=>true})
      }
    end
  end
end

