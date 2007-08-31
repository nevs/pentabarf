class View_find_event < Momomoto::Table
  default_order( Momomoto.lower([:title,:subtitle]))
end

