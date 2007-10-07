

# finds unused views
task :unused_views do
  views = `grep -r 'CREATE OR REPLACE VIEW' sql | sed -e 's/.*:CREATE OR REPLACE VIEW \\([a-z_]\\+\\) AS.*/\\1/'`.split
  views.each do | view |
    sql = `grep -r '\\<#{view}\\>' sql | grep -v 'CREATE OR REPLACE VIEW'`
    if sql.empty?
      rails = `grep -ir '\\<#{view}\\>' rails/app/models`
      if rails.empty?
        puts "Unused view `#{view}` found."
      end
    end
  end
end

# finds files which are not included during install
task :unincluded_files do
  ['tables','views'].each do | type |
    files = `(cd sql && find #{type} -type f)`.split
    files.each do | file |
      sql = `grep  #{file} sql/#{type}.sql`
      if sql.empty?
        puts "Uninclued file `#{file}` found."
      end
    end
  end
end


task :check => [:unused_views,:unincluded_files]

task :default => [:check]

