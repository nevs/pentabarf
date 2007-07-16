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

  # test auth for all public methods
  ImageController.action_methods.each do | method |
    define_method "test_auth_#{method}" do
      get method
      assert_response 401
    end
  end

  def test_person
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
    get :person, {:id => 1}
    assert_response :success
  end

  def test_event
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
    get :event, {:id => 1}
    assert_response :success
  end

  def test_conference
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
    get :conference, {:id => 1}
    assert_response :success
  end

end
