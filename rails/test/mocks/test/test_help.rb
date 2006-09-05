require 'application'

# Make double-sure the RAILS_ENV is set to test,
# so fixtures are loaded to the right database
silence_warnings { RAILS_ENV = "test" }

require 'test/unit'
require 'action_controller/test_process'
require 'action_controller/integration'
require 'action_web_service/test_invoke'
require 'breakpoint'

