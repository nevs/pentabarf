require 'test_helper'

class PersonControllerTest < ActionController::TestCase

  def setup
    @controller = PersonController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    authenticate_user( Account.select_single(:login_name=>'committee') )
  end

  def test_person
    get :new
    assert_response :success
  end

end
