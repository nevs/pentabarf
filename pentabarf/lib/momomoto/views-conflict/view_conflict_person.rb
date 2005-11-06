module Momomoto
  class View_conflict_person < Base
    def initialize
      super
      @domain = 'conflict'
      @order = 'conflict_id, name'
      @query = "SELECT conflict_person.conflict_id, 
                       conflict_person.person_id,
                       conference_phase_conflict.conflict_level_id,
                       view_conflict_level.name AS level_name,
                       view_conflict_level.tag AS level_tag,
                       view_conflict.language_id,
                       view_conflict.tag AS conflict_tag,
                       view_conflict.name AS conflict_name,
                       view_person.name 
                  FROM conflict_person(%conference_id%) 
                       LEFT JOIN conference ON (conference_id = %conference_id%)
                       INNER JOIN conference_phase_conflict USING (conference_phase_id, conflict_id) 
                       INNER JOIN view_conflict USING (conflict_id) 
                       INNER JOIN view_conflict_level USING (conflict_level_id, language_id)
                       INNER JOIN view_person USING (person_id)"
      @fields = {
        :conference_id => Datatype::Integer.new({:parameter=>true}),
        :conflict_id => Datatype::Integer.new,
        :person_id => Datatype::Integer.new,
        :conflict_level_id => Datatype::Integer.new,
        :level_name => Datatype::Text.new,
        :level_tag => Datatype::Text.new,
        :language_id => Datatype::Integer.new,
        :conflict_tag => Datatype::Text.new,
        :conflict_name => Datatype::Text.new,
        :name => Datatype::Text.new
      }
    end
  end
end

