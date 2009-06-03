require File.dirname(__FILE__) + '/../test_helper'

class ConferenceControllerTest < ActionController::TestCase
  def setup
    @controller = ConferenceController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    authenticate_user( Account.select_single(:login_name=>'committee') )
  end

  test "new conference" do
    get :new
    assert_response :success
  end

  test "edit conference" do
    get :edit, {:conference_id=>1}
    assert_response :success
  end

end
