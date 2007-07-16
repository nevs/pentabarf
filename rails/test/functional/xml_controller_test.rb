require File.dirname(__FILE__) + '/../test_helper'
require 'xml_controller'

# Re-raise errors caught by the controller.
class XmlController; def rescue_action(e) raise e end; end

class XmlControllerTest < Test::Unit::TestCase
  def setup
    @controller = XmlController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # test auth for all public methods
  XmlController.action_methods.each do | method |
    define_method "test_auth_#{method}" do
      get method
      assert_response 401
    end
  end

end
