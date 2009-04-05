

desc "finds unused views"
task :unused_views do
  views = `grep -r 'CREATE OR REPLACE VIEW' sql | sed -e 's/.*:CREATE OR REPLACE VIEW \\([a-z_.]\\+\\) AS.*/\\1/'`.split
  views.each do | view |
    view = view.split('.').last
    sql = `grep -r '\\<#{view}\\>' sql | grep -v 'CREATE OR REPLACE VIEW'`
    if sql.empty?
      rails = `grep -ir '\\<#{view}\\>' rails/app/models`
      if rails.empty?
        puts "Unused view `#{view}` found."
      end
    end
  end
end

desc "finds unused models"
task :unused_models do
  models = `grep -r '^class ' rails/app/models | sed -e 's/.*:class \\([A-Z][a-z_]\\+\\) .*/\\1/'`.split
  models.each do | model |
    next if model.match(/^View_(conference|event|person)_image_modification$/)
    used = false
    ['app/controllers', 'app/views','lib','test'].each do | dir |
      if not `grep -r '\\<#{model}\\>' rails/#{dir}`.empty?
        used = true
        break
      end
    end
    puts "Unused model `#{model}` found." if not used
  end
end

desc "finds sql files which are not included during install"
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

desc "regenerate CSS file"
task :update_css do
  `cat rails/public/stylesheets/main.template | sed -e 's!.*"\\(.*\\)".*!rails/public/stylesheets/\\1!' | xargs cat > rails/public/stylesheets/main.css`
end

# alias for update_css
task :css => [:update_css]

task :check => [:unincluded_files,:unused_views,:unused_models]

task :default => [:update_css]

desc "run rails tests"
task :test do
  sh "(cd rails && rake test)"
end

desc "update initial data"
task :update_data do
  sh "(cd sql/data && ruby update_data)"
end

desc "find unlocalized strings in the templates"
task :unlocalized do
  template_dir = "rails/app/views/"
  template_dir += ENV['CONTROLLER'] if ENV['CONTROLLER']
  sh( "grep -rn \"xml.\\w\\+[\\! (]\\+'[^']\\+'\" #{template_dir}", {:verbose=>false} ) {}
#  sh( "grep -r 'xml.\\w\\+[\\! (]\\+\"[^\"]\\+\"' #{template_dir}" ) {}
  sh( "grep -rn 'xml.script' #{template_dir} | grep 'alert\([^\)]\\+)'", {:verbose=>false} ) {}
  sh( "grep -rnv 'xml.script' #{template_dir} | grep 'xml.\\w\\+[\\! (]\\+\"[^\"]\\+\"'", {:verbose=>false} ) {}
end

