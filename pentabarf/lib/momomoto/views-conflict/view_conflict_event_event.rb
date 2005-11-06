module Momomoto
  class View_conflict_event_event < Base
    def initialize
      super
      @domain = 'conflict'
      @order = 'conflict_id, title1, title2'
      @query = "SELECT conflict_event_event.conflict_id, 
                       conflict_event_event.event_id1,
                       conflict_event_event.event_id2,
                       conference_phase_conflict.conflict_level_id,
                       view_conflict_level.name AS level_name,
                       view_conflict_level.tag AS level_tag,
                       view_conflict.language_id,
                       view_conflict.tag AS conflict_tag,
                       view_conflict.name AS conflict_name,
                       event1.title1,
                       event2.title2
                  FROM conflict_event_event(%conference_id%) 
                       LEFT JOIN conference ON (conference_id = %conference_id%)
                       INNER JOIN conference_phase_conflict USING (conference_phase_id, conflict_id) 
                       INNER JOIN view_conflict USING (conflict_id) 
                       INNER JOIN view_conflict_level USING (conflict_level_id, language_id)
                       INNER JOIN (SELECT event_id AS event_id1, title AS title1 FROM event) AS event1 USING (event_id1)
                       INNER JOIN (SELECT event_id AS event_id2, title AS title2 FROM event) AS event2 USING (event_id2)"
      @fields = {
        :conference_id => Datatype::Integer.new({:parameter=>true}),
        :conflict_id => Datatype::Integer.new,
        :event_id1 => Datatype::Integer.new,
        :event_id2 => Datatype::Integer.new,
        :conflict_level_id => Datatype::Integer.new,
        :level_name => Datatype::Text.new,
        :level_tag => Datatype::Text.new,
        :language_id => Datatype::Integer.new,
        :conflict_tag => Datatype::Text.new,
        :conflict_name => Datatype::Text.new,
        :title1 => Datatype::Text.new,
        :title2 => Datatype::Text.new
      }
    end
  end
end

