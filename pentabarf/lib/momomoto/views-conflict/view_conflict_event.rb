module Momomoto
  class View_conflict_event < Base
    def initialize
      super
      @domain = 'conflict'
      @query = "SELECT conflict_event.conflict_id, 
                       conflict_event.event_id,
                       conference_phase_conflict.conference_phase_id,
                       conference_phase_conflict.conflict_level_id,
                       view_conflict_level.name AS level_name,
                       view_conflict_level.tag AS level_tag,
                       view_conflict.language_id,
                       view_conflict.tag AS conflict_tag,
                       view_conflict.name AS conflict_name,
                       event.title
                  FROM conflict_event(%conference_id%) 
                       INNER JOIN conference_phase_conflict USING (conflict_id) 
                       INNER JOIN view_conflict USING (conflict_id) 
                       INNER JOIN view_conflict_level USING (conflict_level_id, language_id)
                       INNER JOIN event USING (event_id)"
      @fields = {
        :conference_id => Datatype::Integer.new({:parameter=>true}),
        :conflict_id => Datatype::Integer.new,
        :event_id => Datatype::Integer.new,
        :conference_phase_id => Datatype::Integer.new,
        :conflict_level_id => Datatype::Integer.new,
        :level_name => Datatype::Text.new,
        :level_tag => Datatype::Text.new,
        :language_id => Datatype::Integer.new,
        :conflict_tag => Datatype::Text.new,
        :conflict_name => Datatype::Text.new,
        :title => Datatype::Text.new
      }
    end
  end
end

