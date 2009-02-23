class Conference_track < Momomoto::Table
  default_order( [:rank, Momomoto::lower(:conference_track)] )
end

