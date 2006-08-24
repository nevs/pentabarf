# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
ENV['RAILS_ENV'] ||= 'development'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '1.1.6'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence those specified here

  # Skip frameworks you're not going to use
  # config.frameworks -= [ :action_web_service, :action_mailer ]
  config.frameworks -= [ :active_record, :action_web_service ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store

  # See Rails::Configuration for more options
end

# Include your application configuration below

$LOAD_PATH.unshift( RAILS_ROOT + '/vendor/momomoto' )

require 'yaml'
require 'momomoto'
require 'erubishandler'
require 'jabberlogger'

# register Erubis as Template Handler for erb templates
ActionView::Base::register_template_handler( 'erubis', ErubisHandler )

# connect to the database
Momomoto::Database.instance.config( YAML.load_file( File.join( RAILS_ROOT, 'config', 'database.yml' ) )[RAILS_ENV] )
Momomoto::Database.instance.connect

