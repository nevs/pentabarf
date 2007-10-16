class Set_config < Momomoto::Procedure
  schema_name( 'pg_catalog' )
  parameters( [
    {:setting=>Momomoto::Datatype::Text.new},
    {:value=>Momomoto::Datatype::Text.new},
    {:is_local=>Momomoto::Datatype::Boolean.new(:not_null=>true)}
  ])
end

