module Momomoto
  class View_conflict_person < Base
    def initialize
      super
      @domain = 'conflict'
      @parameter = [:conference_id, :conference_phase_id, :language_id]
      @query = "SELECT conflict_person.conflict_id, 
                       conflict_person.person_id,
                       conference_phase_conflict.conference_phase_id,
                       conference_phase_conflict.conflict_level_id 
                       view_conflict.language_id,
                       view_conflict.tag AS conflict_tag,
                       view_conflict.name AS conflict_name,
                       view_person.name, 
                  FROM conflict_person('%1%') 
                       INNER JOIN conference_phase_conflict USING (conflict_id) 
                       INNER JOIN view_conflict USING (conflict_id) 
                       INNER JOIN view_person USING (person_id) 
                 WHERE view_conflict.language_id = '%3%' AND 
                       conference_phase_id = '%2%';"
      @fields = {
        :conflict_id => Datatype::Integer.new,
        :person_id => Datatype::Integer.new,
        :conference_phase_id => Datatype::Integer.new,
        :conflict_level_id => Datatype::Integer.new,
        :language_id => Datatype::Integer.new,
        :conflict_tag => Datatype::Text.new,
        :conflict_name => Datatype::Text.new,
        :name => Datatype::Text.new
      }
    end
  end
end

