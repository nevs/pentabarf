class Event_transaction < Momomoto::Table
  default_order( Momomoto::desc(:changed_when) )
end

