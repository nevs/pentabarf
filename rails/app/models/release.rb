
module Release

  def self.const_missing( table )
    klass = Class.new( Momomoto::Table )
    klass.schema_name = "release"

    # copy custom methods from base class to release class if available
    if "::#{table}".constantize.const_defined?('Methods')
      klass.const_set(:Methods, "::#{table}::Methods".constantize)
    end

    Release.const_set(table, klass)
  end

end

