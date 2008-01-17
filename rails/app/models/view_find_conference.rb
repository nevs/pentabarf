class View_find_conference < Momomoto::Table
  default_order( Momomoto.lower(:acronym) )
end

