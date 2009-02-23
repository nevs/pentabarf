class Conference_room < Momomoto::Table
  default_order( [:rank, Momomoto::lower(:conference_room)] )
end

