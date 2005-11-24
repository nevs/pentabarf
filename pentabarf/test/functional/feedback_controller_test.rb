require File.dirname(__FILE__) + '/../test_helper'
require 'feedback_controller'

# Re-raise errors caught by the controller.
class FeedbackController; def rescue_action(e) raise e end; end

class FeedbackControllerTest < Test::Unit::TestCase
  def setup
    @controller = FeedbackController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
