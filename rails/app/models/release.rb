
module Release

  def self.const_missing( table )
    table_name = table.to_s.downcase
    raise "Invalid class name" unless table_name.match(/^[a-z_]+$/)
    begin
      require "release/#{table_name}"
      raise LoadError if not local_constants.member?( table.to_s )
      Release.const_get(table)
    rescue LoadError
      klass = Class.new( Momomoto::Table )
      klass.schema_name = "release"
      klass.table_name = table_name

      # copy custom methods from base class to release class if available
      # if "::#{table}".constantize.const_defined?('Methods')
      #   klass.const_set(:Methods, "::#{table}::Methods".constantize)
      # end

      Release.const_set(table, klass)
    end
  end

end

