require "form_test_helper"
require 'rails_1-1-6_hack' unless CGIMethods.const_defined? "FormEncodedPairParser"
Test::Unit::TestCase.send :include, FormTestHelper

# I have to include FormTestHelper this way or it loads from gems and not vendor:
module ActionController::Integration
  class Session
    include FormTestHelper
  end
end