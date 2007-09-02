class View_person < Momomoto::Table
  default_order( Momomoto.lower(:name) )
end

