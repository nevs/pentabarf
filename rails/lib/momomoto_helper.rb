
require 'shared-mime-info'

module MomomotoHelper

  protected

  # writes a row to the database
  # klass is the class derived from Momomoto::Table in which to store the data.
  # values is a hash with the values for this table
  # options is a hash with the following keys:
  #   preset:  hash of override values these are always set and new records are initialized with them
  #   init:    hash of values to be set for new records
  #   except:  Array of field_names not to accept from the values
  #   always:  Array of field_names to always set even if they are not in the values
  #   remove:  remove the row if values[:remove] is true
  def write_row( klass, values, options = {}, &block )
    return if not values
    options[:except] ||= []; options[:always] ||= []
    options[:always] << options[:always] unless options[:always].instance_of?( Array )
    options[:preset] ||= {}; options[:init] ||= {};
    options[:remove] ||= false
    options[:only].map!(&:to_sym) if options[:only]
    options[:always].map!(&:to_sym)
    row = klass.select_or_new( options[:preset] ) do | field | values[field] end
    current_transaction_id = values.delete('current_transaction_id')

    if options[:remove] && values['remove']
      if not row.new_record?
        check_current_transaction_id( current_transaction_id, row )
        row.delete
      end
      return row
    end

    if options[:ignore_empty]
      return row if !values[ options[:ignore_empty] ] || values[ options[:ignore_empty] ] == ""
    end

    options[:init].each do | field, value |
      row[ field ] = value
    end if row.new_record?


    values.each do | field, value |
      next if klass.primary_keys.member?( field.to_sym ) ||
              options[:except].member?( field.to_sym ) ||
              options[:preset].key?( field.to_sym )
      next if options[:only] && !options[:only].member?( field.to_sym )
      row[ field ] = value
    end
    options[:always].each do | field_name |
      row[ field_name ] = nil unless values.key?( field_name.to_s )
    end
    yield row if block_given?

    if row.dirty?
      check_current_transaction_id( current_transaction_id, row )
      row.write
    end

    row
  end

  # check that we are mofifying the most recent row
  def check_current_transaction_id( current_transaction_id, row )
    current_transaction_id = current_transaction_id.to_i

    # current_transaction_id is 0 if there is no log_transaction_id available 
    if current_transaction_id != 0 && current_transaction_id != row.current_transaction_id
      # mismatching transaction ids means we tried to modify an outdated row
      # check if there really was a conflicting edit
      log_table = "Log::#{row.class.table.table_name.capitalize}".constantize
      begin
        row_old = row.get_transaction_id( current_transaction_id )
      rescue Momomoto::Nothing_found
        # old row not available
        row_old = row.new
      end
      row_now = row.get_transaction_id( row.current_transaction_id )
      modified_columns = compare_transactions( row_old, row_now )
      real_modified_columns = compare_transactions( row_old, row )
      row.dirty.dup.each do | column |
        if modified_columns.member?( column ) && row[column] != row_now[column]
          # check whether the modification was really in our transaction
          if ! real_modified_columns.member?( column ) && row_old[column] == row[column]
            # the detected modifications resulted from us working on an old transaction
            # ignore this column in this save 
            row[column] = row_now[column]
            row.dirty.delete( column )
          else
            raise "Conflicting edit found for table #{row.class.table.table_name}."
          end
        end
      end
    end
  end

  # returns the modified rows between two transactions
  def compare_transactions( t1, t2 )
    modified_columns = []
    t1.class.table.columns.keys.each do | column |
      next if [:log_transaction_id,:log_operation].member?( column )
      modified_columns << column if t1[column] != t2[column]
    end
    modified_columns
  end

  # writes mulitple rows to the database
  # klass is the class derived from Momomoto::Table in which to store the data.
  # values is a hash of hashes with the values for this table
  # see write_row for documentation of options
  def write_rows( klass, values, options = {}, &block )
    options[:remove] ||= true
    values ||= {}
    values.each do | row_id, hash |
      next if row_id == 'row_id'
      write_row( klass, hash, options, &block )
    end
  end

  # writes a file from an upload into the database
  def write_file_row( klass, values, options = {} )
    return if not values
    data_column = options[:image] ? :image : :data
    # read data from tempfile
    tmpfile = values[data_column]
    if tmpfile and tmpfile != ""
      values[data_column] = tmpfile.read

      if values[:filename] && values[:filename].empty?
        values[:filename] = tmpfile.original_filename
      end

      # get mimetype
      type = MIME.check_magics( tmpfile ) || MIME.check_globs( tmpfile.original_filename ) || "application/octet-stream"
      begin
        mime_type = Mime_type.select_single(:mime_type=>type.to_s)
      rescue Momomoto::Nothing_found
        mime_type = Mime_type.select_single(:mime_type=>'application/octet-stream')
      end
      raise "Unsupported image mimetype '#{type}'" if options[:image] && !mime_type.image
      values[:mime_type] = mime_type.mime_type
    else
      values.delete( data_column )
    end

    options[:remove] ||= true
    write_row( klass, values, options ) do | row |
      return if row.new_record? && !row[data_column]
    end
  end

  # writes a file from an upload into the database
  def write_file_rows( klass, values, options = {} )
    values.each do | key, file |
      next if key == 'rowid'
      write_file_row( Event_attachment, file, options )
    end if values
  end

  def write_person_availability( conference, person, data )
    # person availability
    all_slots = []
    # create array with all slots
    days = Conference_day.select({:conference_id=>conference.conference_id},{:order=>:conference_day})
    days.each do | day |
      24.times do | hour |
        real_hour =  ( conference.day_change.hour + hour ) % 24
        date = day.conference_day + ( ( conference.day_change.hour + hour ) / 24 )
        all_slots.push( "#{date.strftime('%Y-%m-%d')} #{sprintf('%02d',real_hour)}:00:00")
      end
    end

    # get set slots from request
    if data && data.keys
      slots = data.keys
    else
      slots = []
    end
    saved = Person_availability.select({:person_id=>person.person_id,:conference_id=>conference.conference_id})
    saved.each do | slot |
      start = slot.start_date.strftime('%Y-%m-%d %H:%M:%S')
      if slots.member?( start )
        # person available now
        modified = true if slot.delete
      else
        # person remains unavailable
        all_slots.delete( start )
      end
    end

    all_slots.each do | slot |
      if slots.member?( slot )
        # person available
      else
        # person not available -> create record in database
        new_slot = Person_availability.new({
          :person_id=>person.person_id,
          :conference_id=>conference.conference_id,
          :start_date=>slot,
          :duration=>'1:00:00' })
        modified = true if new_slot.write
      end
    end
  end

end

