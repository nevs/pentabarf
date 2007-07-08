class Conference_transaction < Momomoto::Table
  default_order( M::desc(:changed_when) )
end

