
module Log

  def self.const_missing( table )
    klass = Class.new( Momomoto::Table )
    klass.schema_name = "log"
    Log.const_set(table, klass)
  end

end

