class View_schedule_event < Momomoto::Table
  default_order( Momomoto::lower(:title,:subtitle))

  fk_helper_multiple :persons, View_schedule_event_person, [:event_id,:translated]

end

