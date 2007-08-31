class Conference < Momomoto::Table
  default_order( Momomoto.lower(:acronym) )
end
