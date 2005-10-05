require 'postgres'
require 'datatype/bool.rb'
require 'datatype/bytea.rb'
require 'datatype/char.rb'
require 'datatype/date.rb'
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

  class Base
    
    private

      # connection to the database
      @@connection = nil
      # array with permissions of the current user
      @@permissions = []
      # language_id of the user interface
      @@ui_language_id = 0

    protected

      # name of the table this class operates on
      @table = ''
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

      def ui_language_id=( value )
        @@ui_language_id = value.to_i
      end

    public

    attr_reader :limit, :current_record, :order, :new_record

    # we don't want id and type to be handled by method_missing 
    undef id
    undef type

    def fields
      @fields.keys
    end

    def log_error( text )
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
    def length()
      return @resultset.length
    end

    def initialize()
      @table = self.class.name.downcase.gsub( /^.*::/, '') unless @table
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
        raise "Connection to Database failed." 
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
        raise "resultset empty while trying to get #{key}" if @resultset.nil? || @resultset.length == 0
        raise "field #{key} does not exist in table #{self.class.name}[]" if @resultset[@current_record][key.to_sym] == nil
        return @resultset[@current_record][ key.to_sym ].value()
      end
    end

    def []=(key, value)
      raise "Field #{key} does not exist in #{@table}" unless @resultset[@current_record][key.to_sym]
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
        @resultset[@current_record][$1.to_sym].value= value
      else
        self[method_name]
      end
    end

    def each
      @resultset.length.times do | i |
        @current_record = i
        yield( self )
      end
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
      fields = ''
      @fields.each do | key , value | 
        next if value.property(:virtual)
        fields += fields != '' ? ', ' : ''
        fields += key.to_s
      end
      result = execute( "SELECT #{fields} FROM #{@table}" + 
                         compile_where( conditions ) + 
                        ( @order != nil ? " ORDER BY #{@order}" : '' ) +
                        ( @limit != nil ? " LIMIT #{@limit.to_s}" : '' ) +
                        ";" )
      @resultset = []
      result.num_tuples.times do | i |
        @resultset[i] = {}
        result.num_fields.times do | j |
          @resultset[i][result.fieldname(j).to_sym] = @fields[result.fieldname(j).to_sym].clone
          @resultset[i][result.fieldname(j).to_sym].import( result[i][j] )
        end
      end
      @new_record = false
      @current_record = @resultset.length > 0 ? 0 : nil 
      @resultset.length
    end
    
    # search in the resultset for a record with a specific value
    def find_by_id( field_name, value )
      self.each do | record | 
        return self if record[field_name.to_sym] == value
      end
      @current_record = nil
      false
    end

    # write record to database
    def write()
      raise "Views are not writable" if @table[0..4] == 'view_'
      return false unless dirty?
      raise "domain not set for class #{self.class.name}" unless @domain 
      if @new_record 
        if privilege?( 'create' )
          execute( insert() )
        else
          raise "not allowed to write table #{@table} domain #{@domain}\nPermissions: #{@@permissions.inspect}"
        end
      else 
        if privilege?( 'modify' )
          execute( update() )
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
    def dirty?()
      dirty = false
      @resultset[@current_record].each do | field_name, value |
        dirty = true if value.dirty?
      end
      dirty
    end
    
    # begin a transaction
    def begin
      execute( 'BEGIN TRANSACTION;' )
    end

    # commit a transaction
    def commit
      execute( 'COMMIT TRANSACTION;' )
    end

    # roll a transaction back
    def rollback
      execute( 'ROLLBACK TRANSACTION;' )
    end

    # delete current record
    def delete()
      return false unless privilege?( 'create' )
      conditions = {}
      @resultset[@current_record].each do | field_name, value |
        if value.property( :primary_key ) 
          raise "empty primary key field while deleting" if value.write_value == 'NULL'
          conditions[field_name] = value.value
        end
      end
      return false if conditions.length < 1
      execute( "DELETE FROM #{@table}#{compile_where(conditions)};" )
      true
    end

    protected
    
    def privilege?( action )
      @@permissions.member?( "#{action}_#{@domain}")
    end

    def insert()
      fields, values = '', ''
      @resultset[@current_record].each do | field_name, value |
        if value.property(:serial)
          value.value= execute("SELECT nextval('#{@table.to_s[0..28]}_#{field_name.to_s[0..28]}_seq');").to_a[0][0]
        end
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
        if value.property( :primary_key ) 
          conditions[field_name] = value.value
        end
        next unless value.dirty?
        sets += sets == '' ? '' : ', '
        sets += "#{field_name.to_s} = #{value.write_value}"
      end
      return "" unless conditions.length 
      "UPDATE #{@table} SET #{sets} #{compile_where(conditions)};"
    end

    def compile_where( conditions )
      where = ''
      conditions.each do | key , value | 
        next if value.nil? || ( ( value.kind_of?(Array) || value.kind_of?(Hash) ) && value.length == 0 )
        raise "Unknown field #{key} in class #{self.class.name}" if @fields[key] == nil
        if @fields[key].property(:virtual)
          where = where_append( where, "#{@fields[key].filter_write(value)}" )
        elsif value === true 
          where = where_append( where, "#{key} IS NOT NULL" )
        elsif value === false
          where = where_append( where, "#{key} IS NULL" )
        elsif value.instance_of?( Array )
          values = ''
          value.each do | v |
            values += values == '' ? '' : ', '
            values += @fields[key].filter_write( v )
          end
          where = where_append( where, "#{key} IN (#{values})" )
        elsif value.kind_of?(Hash)
          value.each do | op, val |
            operator = case op.to_sym 
                         when :lt then '<' 
                         when :le then '<='
                         when :gt then '>'
                         when :ge then '>='
                         when :eq then '='
                         else next
                       end
            where = where_append( where, "#{key} #{operator} #{@fields[key].filter_write(val)}")
          end
        else
          where = where_append( where, "#{key} = #{@fields[key].filter_write(value)}" )
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
      raise "Connection to Database has not yet been established." if @@connection == nil
      begin
        @@connection.exec( sql )
      rescue => e
        log_error("Query failed: #{sql}")
        raise e 
      end
    end

  end

end
