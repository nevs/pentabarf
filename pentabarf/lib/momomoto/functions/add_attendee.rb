module Momomoto
  class Add_attendee < Base
    def initialize
      super
      @domain = 'person'
      @query = "SELECT add_attendee( %person_id%, %event_id% ) AS person_id"
      @fields = {
        :person_id      => Datatype::Integer.new({:parameter=>true}),
        :event_id       => Datatype::Integer.new({:parameter=>true})
      }
    end
  end
end
