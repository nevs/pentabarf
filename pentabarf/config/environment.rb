# Be sure to restart your webserver when you modify this file.

# Uncomment below to force Rails into production mode
# (Use only when you can't set environment variables through your web/app server)
ENV['RAILS_ENV'] = 'production'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Skip frameworks you're not going to use
  # config.frameworks -= [ :action_web_service, :action_mailer ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/app/services )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake create_sessions_table')
  # config.action_controller.session_store = :active_record_store

  # Enable page/fragment caching by setting a file-based store
  # (remember to create the caching directory and make it readable to the application)
  # config.action_controller.fragment_cache_store = :file_store, "#{RAILS_ROOT}/cache"

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc

  # Use Active Record's schema dumper instead of SQL when creating the test database
  # (enables use of different database adapters for development and test environments)
  # config.active_record.schema_format = :ruby

  # See Rails::Configuration for more options
end

# Add new inflection rules using the following format
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Include your application configuration below

require 'time'
require 'date'
require 'momomoto/momomoto'
require 'momomoto/login'
require 'momomoto/tables'
require 'momomoto/functions'
require 'momomoto/views'
require 'momomoto/views-conflict'
require 'momomoto/views-procedures'
require 'builder'
require 'builder_escape_attributes'

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

      # overwrite render function for rails 0.14.x
      alias compile_template_default compile_template
      alias compile_template_default? compile_template?

      def compile_template( extension, template, file_name, local_assigns)
        compile_template_default( extension, localize( template ), file_name, local_assigns )
      end

      def compile_template?( template, file_name, local_assigns )
        compile_template_default?( template, nil, local_assigns )
      end

  end

  module Helpers
    module FormTagHelper
      alias form_tag_default form_tag
      undef start_form_tag
      def form_tag(url_for_options = {}, options = {}, *parameters_for_url)
        form_tag_default(url_for_options, options, *parameters_for_url) + hidden_field_tag('edittoken', @edittoken)
      end
      alias start_form_tag form_tag
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

# read mail configuration if available
if File.exists?("#{RAILS_ROOT}/config/mail.yml")
  config = YAML.load_file("#{RAILS_ROOT}/config/mail.yml")
  ActionMailer::Base.server_settings = config.each do | k, v | config[k.to_sym] = v end
end


