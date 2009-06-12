class Role < Momomoto::Table
  schema_name "auth"
  default_order [:rank,:role]
end

