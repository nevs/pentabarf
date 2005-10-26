require File.dirname(__FILE__) + '/../test_helper'
require 'pdf_controller'

# Re-raise errors caught by the controller.
class PdfController; def rescue_action(e) raise e end; end

class PdfControllerTest < Test::Unit::TestCase
  def setup
    @controller = PdfController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
