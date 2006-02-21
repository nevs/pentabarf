module Momomoto
  class Own_conference_persons < Base
    def initialize
      super
      @domain = 'public'
      @query = "SELECT conference_person_id,
                       %person_id% AS person_id
                  FROM (SELECT own_conference_persons AS conference_person_id FROM own_conference_persons(%person_id%)) AS conference_persons"
      @fields = {
        :person_id              => Datatype::Integer.new({:parameter=>true}),
        :conference_person_id   => Datatype::Integer.new({})
      }
    end
  end
end

