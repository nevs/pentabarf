module Momomoto
  class View_conflict_attendee < Base
    def initialize
      super
      @domain = 'conflict'
      @order = 'title1, title2, name'
      @query = "SELECT conflict_event_person_event.person_id,
                       conflict_event_person_event.event_id1,
                       conflict_event_person_event.event_id2,
                       view_person.name,
                       event1.title1,
                       event2.title2
                  FROM conflict_event_person_event_time_attendee(%conference_id%) AS conflict_event_person_event
                       INNER JOIN view_person USING (person_id)
                       INNER JOIN (SELECT event_id AS event_id1, title AS title1 FROM event) AS event1 USING (event_id1)
                       INNER JOIN (SELECT event_id AS event_id2, title AS title2 FROM event) AS event2 USING (event_id2)"
      @where_append = 'event_id1 > event_id2'
      @fields = {
        :conference_id => Datatype::Integer.new({:parameter=>true}),
        :person_id => Datatype::Integer.new,
        :event_id1 => Datatype::Integer.new,
        :event_id2 => Datatype::Integer.new,
        :name => Datatype::Text.new,
        :title1 => Datatype::Text.new,
        :title2 => Datatype::Text.new
      }
    end
  end
end

