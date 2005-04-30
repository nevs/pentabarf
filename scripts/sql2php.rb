#!/usr/bin/ruby

=begin

   script for converting sql table definitions to php classes

=end

class Table

   def initialize( name , data_types)
      @name = name
      @fields = Hash.new
      @data_types = data_types
   end
   
   def add_field( key, value )
      @fields[ key ] = value
   end

   def get_field( key )
      @fields[ key ]
   end

   def write
      codefile = File.open("#{@name}.php", "w")
      codefile.puts "<?php"
      codefile.puts ""
      codefile.puts "require_once('../classes/database/db_base.php');"

      @data_types.each do | key , value |
         codefile.puts "require_once('../classes/database/datatypes/dt_#{key.downcase}.php');"
      end
      
      codefile.puts ""
      codefile.puts "/// class for accessing and manipulating content of table #{@name}"
      codefile.puts "class #{@name.upcase} extends DB_BASE"
      codefile.puts "{"
      codefile.puts "   /// constructor of the class #{@name}"
      codefile.puts "   public function __construct()"
      codefile.puts "   {"
      codefile.puts "      parent::__construct();"
      codefile.puts "      $this->table = '#{@name}';"
      codefile.puts "      $this->domain = '#{@name}';"
      codefile.puts "      $this->limit = 0;"
      codefile.puts "      $this->order = '';"
      codefile.puts ""

      @fields.each do | key , value |
         parameter = ''
         value.get_parameter.each do | key2, value2 | 
            if parameter.length > 0 
               parameter << ", "
            end
            parameter << "'#{key2}' => #{value2}"
         end
         properties = ''
         value.get_properties.each do | key2, value2 | 
            if properties.length > 0 
               properties << ", "
            end
            properties << "'#{key2}' => #{value2}"
         end
         codefile.puts "      $this->fields['#{key}'] = new DT_#{value.get_type}( $this, '#{key}', array(#{parameter}), array(#{properties}) );"
      end

      codefile.puts "   }"
      codefile.puts ""
      codefile.puts "}"
      codefile.puts ""
      codefile.puts "?>"
   end
   
end

class Field
   
   def initialize( name , type )
      @name = name
      @type = type
      @parameter = Hash.new
      @properties = Hash.new
   end

   def get_type()
      @type
   end

   def get_parameter
      @parameter
   end

   def get_properties
      @properties
   end

   def set_parameter( name, value )
      @parameter[ name ] = value;
   end

   def set_property( name, value )
      @properties[ name ] = value;
   end

end

File.open("tables.sql", "r") do |sqlfile|

   sqlfile.each_line do |line| 
   
      # we found a new table
      if match = /^ *CREATE TABLE ([a-z_0-9]+) *\( *$/.match( line )
         cur_data_types = Hash.new()
         cur_table = Table.new( match[1], cur_data_types ) 
         sqlfile.each_line do |line|

            # are we in an ordinary field
            if match = /^ *([a-z0-9_]+) +(([A-Z]+)(\(([0-9, ]+)\))?).*$/.match( line ) 
               field_name = match[1]
               data_type = match[3]
               cur_field = Field.new( field_name, data_type )

               if data_type == 'BOOL'
               elsif data_type == 'SMALLINT'
               elsif data_type == 'INTEGER'
               elsif data_type == 'SERIAL'
               elsif data_type == 'DECIMAL'
                  parameter = match[5].scan( /[0-9]+/ )
                  cur_field.set_parameter( 'precision', parameter[0])
                  cur_field.set_parameter( 'scale', parameter[1])
               elsif data_type == 'INET'
               elsif data_type == 'CHAR' || data_type == 'VARCHAR'
                  cur_field.set_parameter( 'length', match[5])
               elsif data_type == 'TEXT'
               elsif data_type == 'DATE'
               elsif data_type == 'TIME' || data_type == 'TIMESTAMP' || data_type == 'INTERVAL'
                  if match[5]
                     cur_field.set_parameter( 'precision', match[5])
                  end
               elsif data_type == 'BYTEA'
               else
                  puts "Unsupported Datatype: #{data_type}"
                  exit
               end
               
               cur_data_types[ data_type ] = true;

               if /NOT NULL/.match( line )
                  cur_field.set_property( 'NOT_NULL', "true" )
               end
               if /DEFAULT/.match( line )
                  cur_field.set_property( 'DEFAULT', "true" )
               end
   
               cur_table.add_field( field_name, cur_field )
         
            elsif match = /^ *PRIMARY KEY *\(([a-z0-9_, ]+)\)/.match( line )
               match[1].scan( /[a-z0-9_]+/ ) do | field_name | 
                  cur_table.get_field( field_name ).set_property( "PRIMARY_KEY", "true" )
               end
               
            elsif /^\); *$/.match( line ) or /^\) WITHOUT OIDS; *$/.match( line )
               # we have reached the end of this table 
               cur_table.write()
               break
            elsif /^ *FOREIGN KEY/i.match( line )
            elsif /^ *UNIQUE/i.match( line )
            else
               puts "Unrecognized line: #{line}"
               exit
            end
         end
      end
   end
end

