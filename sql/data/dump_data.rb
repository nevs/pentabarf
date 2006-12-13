#!/usr/bin/env ruby

database = ARGV.shift || 'phoenix'
user = ARGV.shift || 'sven'
tables = [:language, :country, :country_localized, :currency, :language_localized, :conference_phase, :conference_phase_localized, :event_origin, :event_state, :event_state_progress, :event_role, :event_role_state, :event_type]
schema = 'public'

import = File.open('import.sql', 'w')
import.puts("BEGIN TRANSACTION;")
tables.each do | table |
  import.puts("\\i #{table}.sql")
  next if ARGV.length > 0 && !ARGV.member?( table.to_s )
  puts "dumping table #{table}"
  system("pg_dump #{database} -i -a -D -O -x -n #{schema} -U #{user} -t #{table} > #{table}.sql")
end
import.puts("COMMIT TRANSACTION;")


