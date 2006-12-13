require File.dirname(__FILE__) + '/../test_helper'
require 'image_controller'

# Re-raise errors caught by the controller.
class ImageController; def rescue_action(e) raise e end; end

class ImageControllerTest < Test::Unit::TestCase
  def setup
    @controller = ImageController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_person
    get :person, {:id => 1}
    assert_response :success
  end

  def test_event
    get :event, {:id => 1}
    assert_response :success
  end

  def test_conference
    get :conference, {:id => 1}
    assert_response :success
  end

end
