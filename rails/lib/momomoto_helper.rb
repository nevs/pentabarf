
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
    options[:except] ||= []; options[:always] ||= []
    options[:preset] ||= {}; options[:init] ||= {};
    options[:remove] ||= false
    row = klass.select_or_new( options[:preset] ) do | field | values[field] end
    if options[:remove] && values['remove']
      row.delete if not row.new_record?
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
    row.write
    row
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
    conference.days.times do | day |
      24.times do | hour |
        real_hour =  ( conference.day_change.hour + hour ) % 24
        date = conference.start_date + day + ( ( conference.day_change.hour + hour ) / 24 )
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

