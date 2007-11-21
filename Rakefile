

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

# finds unused models
task :unused_models do
  models = `grep -r '^class ' rails/app/models | sed -e 's/.*:class \\([A-Z][a-z_]\\+\\) .*/\\1/'`.split
  models.each do | model |
    next if model.match(/^View_(conference|event|person)_image_modification$/)
    next unless `grep -r '\\<#{model}\\>' rails/app/controllers`.empty?
    next unless `grep -r '\\<#{model}\\>' rails/app/views`.empty?
    next unless `grep -r '\\<#{model}\\>' rails/lib`.empty?
    next unless `grep -r '\\<#{model}\\>' rails/test`.empty?
    puts "Unused model `#{model}` found."
  end
end

# finds files which are not included during install
task :unincluded_files do
  ['tables','views','functions'].each do | type |
    files = `(cd sql && find #{type} -type f)`.split
    files.each do | file |
      sql = `grep  #{file} sql/#{type}.sql`
      if sql.empty?
        puts "Uninclued file `#{file}` found."
      end
    end
  end
end

task :update_css do
  `(cd rails/public/stylesheets && make)`
end


task :check => [:unincluded_files,:unused_views,:unused_models]

task :default => [:check]


