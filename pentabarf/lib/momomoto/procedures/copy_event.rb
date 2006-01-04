module Momomoto
  class Copy_event < Base
    def initialize
      super
      @domain = 'event'
      @query = "SELECT copy_event AS new_event_id, 
                       %event_id% AS event_id, 
                       %conference_id% AS conference_id, 
                       %person_id% AS person_id 
                  FROM copy_event( %event_id%, %conference_id%, %person_id%)"
      @fields = {
        :new_event_id   => Datatype::Integer.new({}),
        :event_id       => Datatype::Integer.new({:parameter=>true}),
        :conference_id  => Datatype::Integer.new({:parameter=>true}),
        :person_id      => Datatype::Integer.new({:parameter=>true})
      }
    end
  end
end

