require 'test_helper'

class EventControllerTest < ActionController::TestCase

  def setup
    @controller = EventController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    authenticate_user( Account.select_single(:login_name=>'committee') )
  end

  def test_event
    get :new
    assert_response :success
  end

end
