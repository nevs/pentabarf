module Momomoto
  class View_related_event_speaker < Base
    def initialize
      super
      @domain = 'event'
      @order = 'lower(event.title), lower(event.subtitle), lower(name)'
      @query = "SELECT related_event_speaker.event_id, 
                       event.title,
                       event.subtitle,
                       person.person_id,
                       person.name
                  FROM related_event_speaker(%event_id%) 
                       INNER JOIN event USING (event_id)
                       INNER JOIN event_person USING (event_id)
                       INNER JOIN event_role ON (
                           event_person.event_role_id = event_role.event_role_id AND 
                           event_role.tag IN ('speaker', 'moderator'))
                       INNER JOIN event_role_state ON (
                           event_person.event_role_state_id = event_role_state.event_role_state_id AND
                           event_role_state.tag = 'confirmed')
                       INNER JOIN (SELECT person_id, name FROM view_person) AS person USING (person_id)"
      @fields = {
        :event_id => Datatype::Integer.new({:parameter=>true}),
        :title => Datatype::Text.new,
        :subtitle => Datatype::Text.new,
        :person_id => Datatype::Integer.new,
        :name => Datatype::Text.new
      }
    end
  end
end

