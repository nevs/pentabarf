require File.dirname(__FILE__) + '/../test_helper'
require 'xcal_controller'

# Re-raise errors caught by the controller.
class XcalController; def rescue_action(e) raise e end; end

class XcalControllerTest < Test::Unit::TestCase
  def setup
    @controller = XcalController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
