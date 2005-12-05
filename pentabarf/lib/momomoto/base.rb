require 'postgres'
require 'date'
require 'time'
require 'datatype/bool.rb'
require 'datatype/boolsearch.rb'
require 'datatype/bytea.rb'
require 'datatype/char.rb'
require 'datatype/date.rb'
require 'datatype/datetime.rb'
require 'datatype/decimal.rb'
require 'datatype/inet.rb'
require 'datatype/integer.rb'
require 'datatype/interval.rb'
require 'datatype/keysearch.rb'
require 'datatype/numeric.rb'
require 'datatype/password.rb'
require 'datatype/preferences.rb'
require 'datatype/smallint.rb'
require 'datatype/text.rb'
require 'datatype/textsearch.rb'
require 'datatype/time.rb'
require 'datatype/timestamp.rb'
require 'datatype/varchar.rb'

module Momomoto 

  class Momomoto_Error < StandardError
  end

  class Connection_failed < Momomoto_Error
  end

  class Connection_not_established < Momomoto_Error
  end

  class Permission_Error < Momomoto_Error
  end

  class Base
    
    private

      # connection to the database
      @@connection = nil
      # array with permissions of the current user
      @@permissions = []
      # language_id of the user interface
      @@ui_language_id = 0
      # person_id of the logged in user
      @@person_id = 0

    protected

      # name of the table this class operates on
      @table = nil
      # domain of the table this class belongs to
      @domain = nil
      # hash with the fields of the table with their name as key
      @fields = {}
      # resultset of the last database query
      @resultset = []
      # index of the current record
      @current_record = nil
      # is the current record a new one
      @new_record = nil
      # limit for select queries
      @limit = nil
      # order for selects
      @order = nil

      def self.ui_language_id=( value )
        @@ui_language_id = value.to_i
      end

    public

    attr_reader :limit, :current_record, :order, :new_record

    # we want id and type to be handled by method_missing 
    undef id
    undef type

    def fields
      real_fields = []
      @fields.each do | field_name, value |
        next if value.property(:virtual)
        real_fields.push( field_name )
      end
      real_fields
    end

    def primary_key_fields
      pk_fields = []
      @fields.each do | field_name, value |
        next unless value.property(:primary_key)
        pk_fields.push( field_name )
      end
      pk_fields
    end

    def self.log_error( text )
      puts text
    end

    def self.ui_language_id
      @@ui_language_id
    end

    # set limit for queries
    def limit=( value )
      value = value.to_i unless value.kind_of?( Integer )
      if value > 0
        @limit = value
      end
    end

    # set order for queries
    def order=( value )
      if value.match( /[a-zA-Z,.()0-9]+/ )
        @order = value
      else
        @order = nil
      end
    end

    # get number of records in resultset
    def length
      return @resultset.length if @resultset
      0
    end

    def initialize
      @table = self.class.name.downcase.gsub( /^.*::/, '') unless @table
    end

    # copy all instance variables except resultset and current_record
    def copy_member( copy )
      self.instance_variables.each do | var |
        next if var == '@resultset' || var == '@current_record'
        copy.instance_variable_set( var, self.instance_variable_get( var ) )
      end
      copy.instance_variable_set( '@resultset', [] )
      copy.instance_variable_set( '@current_record', nil )
      copy
    end

    # returns an instance of the class with one new entry
    def self.new_record()
      new_record = self.new
      new_record.create
      new_record
    end

    # establish connection to the database
    def self.connect( config )
      begin
        @@connection = PGconn.connect( config['host'], config['port'], nil, nil, 
                                       config['database'], config['username'], config['password'])
      rescue => e
        raise Connection_failed
      end
      true
    end

    def [](key)
      if key.kind_of?( Integer )
        if key >= 0 && key < @resultset.length 
          @current_record = key
          return self
        else
          raise "Invalid index for class #{self.class.name}"
        end
      else
        raise "resultset empty while trying to get #{key}" if @resultset.nil?
        raise "@current_record nil in table #{self.class.name} field #{key}" unless @current_record
        raise "field #{key} does not exist in table #{self.class.name}[]" if @resultset[@current_record][key.to_sym] == nil
        return @resultset[@current_record][ key.to_sym ].value()
      end
    end

    def []=(key, value)
      raise "Field #{key} does not exist in #{@table}" unless @resultset[@current_record][key.to_sym]
      raise "Setting primary key fields make no sense in #{@table}:#{key}" if @new_record == false && @resultset[@current_record][key.to_sym].property(:primary_key)
      @resultset[@current_record][key.to_sym].value= value
    end

    # create a new record
    def create()
      @resultset = []
      @resultset[0] = {}
      @fields.each do | field_name, field | 
        next if field.property(:virtual)
        @resultset[0][field_name] = field.clone
        @resultset[0][field_name].value = field.new_value
      end
      @current_record = 0
      @new_record = true
    end

    def method_missing( method_name, value = nil )
      if method_name.to_s =~ /^(.*)=$/
        raise "Unknown field #{$1} in #{self.class.name}" unless @fields.keys.member?($1.to_sym)
        @resultset[@current_record][$1.to_sym].value= value
      else
        self[method_name]
      end
    end

    # iterate over resultset and return a new object
    def slow_each
      @resultset.length.times do | i |
        element = copy_member( self.class.new )
        element.instance_variable_set('@current_record', 0)
        element.instance_variable_set('@resultset', [@resultset[i]])
        yield( element )
      end
    end

    # for performance reasons we don't create new objects while iterating
    def each
      old_record = @current_record
      @resultset.length.times do | i |
        @current_record = i
        yield( self )
      end
      @current_record = old_record
    end

    # iterate over resultset with additional index element
    def slow_each_with_index
      @resultset.length.times do | i |
        element = copy_member( self.class.new )
        element.instance_variable_set('@current_record', 0)
        element.instance_variable_set('@resultset', [@resultset[i]])
        yield( element, i )
      end
    end
    
    def each_with_index
      old_record = @current_record
      @resultset.length.times do | i |
        @current_record = i
        yield( self, i )
      end
      @current_record = old_record
    end

    def nil?
      length > 0 ? false : true
    end

    # class method for finding records
    def self.find( conditions = {} , limit = nil, order = nil, distinct = nil)
      data = self.new
      data.select( conditions, limit, order, distinct )
      return data
    end

    # instance method for finding records
    def find( conditions = {}, limit = nil, order = nil, distinct = nil)
      select( conditions, limit, order, distinct )
      self
    end
    
    def select( conditions = {}, limit = nil, order = nil, distinct = nil ) 
      self.limit= limit if limit
      self.order= order if order
      if @query.to_s.length > 0 
        sql = @query.dup
        @fields.each do | key, value |
          next unless value.property(:parameter)
          raise "missing parameter #{field_name} in #{self.class.name}" if conditions[key].nil?
          sql.gsub!("%#{key.to_s}%", value.filter_write(conditions[key]))
        end
      else
        fields = ''
        @fields.each do | key , value | 
          next if value.property(:virtual)
          fields += fields != '' ? ', ' : ''
          fields += "\"#{key.to_s}\""
        end
        sql = "SELECT #{fields} FROM #{@table}"
      end
      sql += compile_where( conditions ) + ( @order  ? " ORDER BY #{@order}" : '' ) + ( @limit  ? " LIMIT #{@limit.to_s}" : '' ) + ";"
      result = execute( sql )
      @resultset = []
      result.num_tuples.times do | i |
        current = {}
        result.num_fields.times do | j |
          current[result.fieldname(j).to_sym] = @fields[result.fieldname(j).to_sym].clone
          current[result.fieldname(j).to_sym].import( result[i][j] )
        end
        next if distinct && find_by_id(distinct, current[distinct].value)
        @resultset.push( current )
      end
      result.clear
      @new_record = false
      @current_record = @resultset.length > 0 ? 0 : nil 
      @resultset.length
    end
    
    # search in the resultset for a record with a specific value
    def find_by_id( field_name, value )
      @resultset.length.times do | i |
        if @resultset[i][field_name.to_sym].value == value
          @current_record = i
          return true
        end
      end
      @current_record = nil
      false
    end

    # search for the first record with specific values
    def find_by_value( values )
      return false if length == 0 
      return false unless values.kind_of?(Hash)
      found = false
      @resultset.length.times do | i |
        values.each do | key, value |
          if @resultset[i][key].value == value
            found = true
          else
            found = false
            break
          end
        end
        @current_record = i
        return true if found
      end
      @current_record = nil
      false
    end

    # iterate over records with specific values of a resultset 
    def each_by_value( values )
      return false unless values.kind_of?(Hash)
      old_record = @current_record
      self.each do | record |
        found = false
        values.each do | key, value |
          if record[key] == value
            found = true
          else
            found = false
            break
          end
        end
        yield( record ) if found
      end
      @current_record = old_record
    end

    def each_unique( field )
      return unless @fields.member?(field.to_sym)
      old_record = @current_record
      done = []
      self.each do | record | 
        next if done.member?( record[field] )
        done.push( record[field])
        yield( record )
      end
      @current_record = old_record
    end


    # write record to database
    def write()
      raise "Views are not writable" if @table[0..4] == 'view_'
      return false unless dirty?
      raise "domain not set for class #{self.class.name}" unless @domain 
      if @new_record 
        if privilege?( 'create' )
          result = execute( insert() )
          result.clear
        else
          raise "not allowed to write table #{@table} domain #{@domain}\nPermissions: #{@@permissions.inspect}"
        end
      else 
        if privilege?( 'modify' )
          execute( log_changes() ) if @log_changes
          result = execute( update() )
          result.clear
        else
          raise "not allowed to modify table #{@table} domain #{@domain}\nPermissions: #{@@permissions.inspect}"
        end
      end
      true
    end

    # has the current user a specific permission
    def permission?( action )
      @@permissions.member?( action )
    end

    # has the record been modified
    def dirty?
      @resultset[@current_record].each do | field_name, value |
        next if value.property(:auto_update)
        return true if value.dirty?
      end
      false
    end

    # has any of the non primary key fields data except those in except
    def data?( except = [] )
      @fields.each do | field_name, value |
        next if except.member?( field_name )
        next if value.property( :virtual )
        next if value.property( :primary_key )
        return true if value.value != nil
      end
      false
    end
    
    # begin a transaction
    def begin
      result = execute( 'BEGIN TRANSACTION;' )
      result.clear
    end

    # commit a transaction
    def commit
      result = execute( 'COMMIT TRANSACTION;' )
      result.clear
    end

    # roll a transaction back
    def rollback
      result = execute( 'ROLLBACK TRANSACTION;' )
      result.clear
    end

    # delete current record
    def delete()
      return false unless privilege?( 'delete' )
      conditions = {}
      @resultset[@current_record].each do | field_name, value |
        if value.property( :primary_key ) 
          raise "empty primary key field while deleting" if value.write_value == 'NULL'
          conditions[field_name] = value.value
        end
      end
      raise "deleting without constraints is probably a bad idea in table #{@table}" if conditions.length < 1
      execute( log_changes() ) if @log_changes
      result = execute( "DELETE FROM #{@table}#{compile_where(conditions)};" )
      result.clear
      true
    end

    protected
    
    def privilege?( action )
      return true if @domain == 'public'
      return true if @@permissions.member?( "#{action}_#{@domain}")
      return true if @domain == 'person' && @@person_id == self[:person_id] && @@permissions.member?("modify_own_person")
      false
    end

    def insert()
      fields, values = '', ''
      @resultset[@current_record].each do | field_name, value |
        if value.property(:serial)
          result = execute("SELECT nextval(pg_get_serial_sequence('#{@table.to_s}', '#{field_name.to_s}'));")
          value.value= result.to_a[0][0]
          result.clear
        end
        value.value= @@person_id if field_name == :last_modified_by
        next if value.property( :default ) && value.write_value == 'NULL'
        raise "not null field with null value in class #{self.class.name} field #{field_name} in insert" if value.property( :not_null ) && value.write_value == 'NULL'
        fields += fields == '' ? '' : ', '
        fields += field_name.to_s
        values += values == '' ? '' : ', '
        values += value.write_value() 
      end
      "INSERT INTO #{@table}(#{fields}) VALUES(#{values});"
    end

    def update()
      sets, conditions = '', {}
      @resultset[@current_record].each do | field_name, value |
        raise "not null field with null value in class #{self.class.name} field #{field_name} in update" if value.property( :not_null ) && value.write_value == 'NULL'
        value.value= @@person_id if field_name == :last_modified_by
        if value.property( :primary_key ) 
          conditions[field_name] = value.value
        end
        next unless value.dirty?
        sets += sets == '' ? '' : ', '
        sets += "#{field_name.to_s} = #{value.write_value}"
      end
      raise "updating without constraints is probably a bad idea in table #{@table}" if conditions.length < 1
      "UPDATE #{@table} SET #{sets} #{compile_where(conditions)};"
    end

    def log_changes()
      sets, primary_keys = '', {}
      @resultset[@current_record].each do | field_name, value |
        next unless value.property( :primary_key ) 
        raise "empty primary key field in class #{self.class.name} field #{field_name} in log_changes" if value.write_value == 'NULL'
        primary_keys[field_name] = value.value
      end
      fields = @fields.keys.join(', ')
      raise "logging without constraints is probably a bad idea in table #{@table}" if primary_keys.length < 1
      "INSERT INTO #{@table}_logging(#{fields}) SELECT #{fields} FROM #{@table} #{compile_where(primary_keys)};"
    end

    def compile_where( conditions )
      where = ''
      conditions.each do | key , value | 
        raise "Unknown field #{key} in class #{self.class.name}" if @fields[key] == nil
        next if @fields[key].property(:parameter) || ( ( value.kind_of?(Array) || value.kind_of?(Hash) ) && value.length == 0 )
        if @fields[key].property(:virtual)
          where = where_append( where, "#{@fields[key].filter_write(value)}" )
        elsif value == true 
          where = where_append( where, "#{key} IS NOT NULL" )
        elsif value == false or value == nil
          where = where_append( where, "#{key} IS NULL" )
        else
          value = {:eq => [value]} if value.kind_of?(String) || value.kind_of?(Integer)
          value = {:eq => value} if value.kind_of?(Array)
          value.each do | op, val |
            operator = case op.to_sym 
                         when :lt then '<' 
                         when :le then '<='
                         when :gt then '>'
                         when :ge then '>='
                         when :eq then '='
                         when :ne then '<>'
                         else next
                       end
            val = [val] unless val.kind_of?(Array)
            val.collect! do | v | "#{key} #{operator} #{@fields[key].filter_write(v)}" end
            where = where_append( where, "( " + val.join( op.to_sym == :ne ? " AND " : " OR ") + ")")
          end
        end
      end
      where
    end

    def where_append( where, append )
      where += where == '' ? ' WHERE ' : ' AND '
      where += append
    end
    
    private
      
    def execute( sql )
      raise Connection_not_established if @@connection == nil
      begin
        @@connection.exec( sql )
      rescue => e
        Base.log_error("Query failed: #{sql}")
        raise e 
      end
    end

  end

end

