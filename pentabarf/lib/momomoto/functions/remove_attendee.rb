module Momomoto
  class Remove_attendee < Base
    def initialize
      super
      @domain = 'person'
      @query = "SELECT remove_attendee( %person_id%, %event_id% ) AS person_id"
      @fields = {
        :person_id      => Datatype::Integer.new({:parameter=>true}),
        :event_id       => Datatype::Integer.new({:parameter=>true})
      }
    end
  end
end
