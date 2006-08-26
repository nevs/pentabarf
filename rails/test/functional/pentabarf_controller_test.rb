require File.dirname(__FILE__) + '/../test_helper'
require 'pentabarf_controller'

# Re-raise errors caught by the controller.
class PentabarfController; def rescue_action(e) raise e end; end

class PentabarfControllerTest < Test::Unit::TestCase

  def setup
    @controller = PentabarfController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
  end

  def test_person
    get :person, {:id => 1}
    assert_response :success
  end

  def test_new_person
    get :person, {:id => 'new'}
    assert_response :success
  end

  def test_event
    get :event, {:id => 1}
    assert_response :success
  end

  def test_new_event
    get :event, {:id => 'new'}
    assert_response :success
  end

  def test_conference
    get :conference, {:id => 1}
    assert_response :success
  end

  def test_new_conference
    get :conference, {:id => 'new'}
    assert_response :success
  end

end

