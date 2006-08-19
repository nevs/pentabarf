#!/usr/bin/env ruby

database = ARGV[0] || 'phoenix'
user = ARGV[1] || 'sven'
tables = [:country, :currency, :conference_phase, :event_origin, :event_state, :event_state_progress, :event_role, :event_role_state]
schema = 'public'

import = File.open('import.sql', 'w')
import.puts("BEGIN TRANSACTION;")
tables.each do | table | 
  puts "dumping table #{table}"
  system("pg_dump #{database} -i -a -D -O -x -n #{schema} -U #{user} -t #{table} > #{table}.sql")
  import.puts("\\i #{table}.sql")
end
import.puts("COMMIT TRANSACTION;")


