require File.dirname(__FILE__) + '/../test_helper'
require 'localization_controller'

# Re-raise errors caught by the controller.
class LocalizationController; def rescue_action(e) raise e end; end

class LocalizationControllerTest < Test::Unit::TestCase
  def setup
    @controller = LocalizationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
