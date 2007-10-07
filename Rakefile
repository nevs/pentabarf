

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

