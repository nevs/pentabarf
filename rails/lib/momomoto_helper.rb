
module MomomotoHelper

  # writes a row to the database
  # klass is the class derived from Momomoto::Table in which to store the data.
  # values is a hash with the values for this table
  # options is a hash with the following keys:
  #   preset:  hash of override values these are always set and new records are initialized with them
  #   except:  Array of field_names not to accept from the values
  #   always:  Array of field_names to always set even if they are not in the values
  #   remove:  remove the row if values[:remove] is true
  def write_row( klass, values, options = {}, &block )
    options[:except] ||= []; options[:always] ||= []
    options[:preset] ||= {}; options[:remove] ||= false
    row = klass.select_or_new( options[:preset] ) do | field | values[field] end
    if options[:remove] && values['remove']
      row.delete if not row.new_record?
      return row
    end
    values.each do | field, value |
      next if klass.primary_keys.member?( field.to_sym ) ||
              options[:except].member?( field.to_sym ) ||
              options[:preset].keys.member?( field.to_sym )
      row[ field ] = value
    end
    options[:always].each do | field_name |
      row[ field_name ] = nil unless values.keys.include?( field_name.to_s )
    end
    yield row if block_given?
    row.write
    row
  end

  # writes mulitple rows to the database
  # klass is the class derived from Momomoto::Table in which to store the data.
  # values is a hash of hashes with the values for this table
  # see write_row for documentation of options
  def write_rows( klass, values, options = {}, &block )
    options[:remove] ||= true
    values.each do | row_id, hash |
      next if row_id == 'row_id'
      write_row( klass, hash, options, &block )
    end
  end

end

