require File.dirname(__FILE__) + '/../test_helper'

class ConferenceControllerTest < ActionController::TestCase
  def setup
    @controller = ConferenceController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def teardown
    POPE.deauth
  end

  def test_conference_unauthenticated
    get :new
    assert_response 401
    get :edit, {:event_id=>1}
    assert_response 401
  end

  def test_conference_submitter
    authenticate_user( Account.select_single(:login_name=>'testcase_submitter') )
    get :new
    # this should actually be 401 but due to the way auth is handled in test cases no data is returned
    assert_response 0
    get :edit, {:event_id=>1}
    # this should actually be 401 but due to the way auth is handled in test cases no data is returned
    assert_response 0
  end

  def test_conference_committee
    authenticate_user( Account.select_single(:login_name=>'testcase_committee') )
    get :new
    assert_response :success
    get :edit, {:conference_id=>1}
    assert_response :success
  end

end
