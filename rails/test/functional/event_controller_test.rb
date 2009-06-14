require 'test_helper'

class EventControllerTest < ActionController::TestCase

  def setup
    @controller = EventController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def teardown
    POPE.deauth
  end

  def test_event_unauthenticated
    get :new
    assert_response 401
    get :edit, {:event_id=>1}
    assert_response 401
  end

  def test_event_submitter
    authenticate_user( Account.select_single(:login_name=>'testcase_submitter') )
    get :new
    assert_response 401

    authenticate_user( Account.select_single(:login_name=>'testcase_submitter') )
    get :edit, {:event_id=>1}
    assert_response 401
  end

  def test_event_committee
    authenticate_user( Account.select_single(:login_name=>'testcase_committee') )
    get :new
    assert_response :success

    authenticate_user( Account.select_single(:login_name=>'testcase_committee') )
    get :edit, {:event_id=>1}
    assert_response :success
  end

  def test_event_conference_committee
    authenticate_user( Account.select_single(:login_name=>'testcase_conference_committee') )
    get :new
    assert_response :success

    authenticate_user( Account.select_single(:login_name=>'testcase_conference_committee') )
    get :edit, {:event_id=>1}
    assert_response :success
  end

  def test_event_conference_reviewer
    authenticate_user( Account.select_single(:login_name=>'testcase_conference_reviewer') )
    get :new
    assert_response 401

    authenticate_user( Account.select_single(:login_name=>'testcase_conference_reviewer') )
    get :edit, {:event_id=>1}
    assert_response :success
  end

end
