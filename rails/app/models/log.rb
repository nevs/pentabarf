
module Log

  def self.const_missing( table )
    klass = Class.new( Momomoto::Table )
    klass.schema_name = "log"

    # copy custom methods from base class to log class if available
    if "::#{table}".constantize.const_defined?('Methods')
      klass.const_set(:Methods, "::#{table}::Methods".constantize)
    end

    Log.const_set(table, klass)
  end

end

