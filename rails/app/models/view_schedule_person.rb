class View_schedule_person < Momomoto::Table

  fk_helper_multiple :events, View_schedule_event_person, [:person_id]
  fk_helper_multiple :links, Conference_person_link, [:conference_person_id]

end

