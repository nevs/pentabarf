
module Custom

  def self.const_missing( table )
    klass = Class.new( Momomoto::Table )
    klass.schema_name = "custom"
    klass.table_name = "custom_#{table.to_s.downcase}"
    Custom.const_set(table, klass)
  end

end

