unless defined?(RAILS_ROOT)
  root_path = File.join(File.dirname(__FILE__), '..')
  unless RUBY_PLATFORM =~ /mswin32/
    require 'pathname'
    root_path = Pathname.new(root_path).cleanpath.to_s
  end
  RAILS_ROOT = root_path
end

if File.directory?("#{RAILS_ROOT}/vendor/rails")
  require "#{RAILS_ROOT}/vendor/rails/railties/lib/initializer"
else
  require 'rubygems'
  require 'initializer'
end

Rails::Initializer.run(:set_load_path)

require 'time'
require 'date'
require 'momomoto/momomoto'
require 'momomoto/login'
require 'momomoto/tables'
require 'momomoto/views'
require 'momomoto/views-conflict'

Momomoto::Base.connect(YAML::load_file("#{RAILS_ROOT}/config/database.yml")[RAILS_ENV])

# we want localization in our rhtml renderer
module ActionView
  class Base
    private

      def localize( template )
        # lets do some localization
        tags = template.to_s.scan(/<\[[a-z:_]+\]>/)
        tags.collect do | tag |
          tag.delete!("<[]>")
        end
        if tags.length > 0
          Momomoto::View_ui_message.find({:language_id => Momomoto::Base.ui_language_id, :tag => tags}).each do | msg |
            next if msg.name.match(/[{}<>]/)
            template.gsub!( "<[" + msg.tag + "]>", h(msg.name) )
          end
        end
        template
      end

      # overwrite render function for rails 0.14.1
      begin
        Base::instance_method("compile_template")
        alias compile_template_default compile_template
      rescue
      end

      def compile_template( extension, template, file_path, local_assigns)
        compile_template_default( extension, localize( template ), file_path, local_assigns )
      end

      def compile_template?( template, file_name, local_assigns )
        true
      end

      # overwrite render function for rails 0.13.1
      begin
        Base::instance_method("rhtml_render")
        alias rhtml_render_default rhtml_render
      rescue
      end

      def rhtml_render(extension, template, local_assigns)
        rhtml_render_default(extension, localize(template), local_assigns)
      end

  end
end

module Momomoto
  class Base
    def self.log_error( text )
      ApplicationController.jabber_message( text )
    end
  end
end


