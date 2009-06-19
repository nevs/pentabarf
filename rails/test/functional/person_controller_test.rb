require 'test_helper'

class PersonControllerTest < ActionController::TestCase

  def setup
    @controller = PersonController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_person_committee
    authenticate_user( Account.select_single(:login_name=>'testcase_committee') )
    get :new
    assert_response :success

    authenticate_user( Account.select_single(:login_name=>'testcase_committee') )
    get :edit, {:person_id=>1}
    assert_response :success
  end

  def test_person_submitter
    authenticate_user( Account.select_single(:login_name=>'testcase_submitter') )
    get :new
    assert_response 401

    authenticate_user( Account.select_single(:login_name=>'testcase_submitter') )
    get :edit, {:person_id=>1}
    assert_response 401
  end

  def test_person_conference_reviewer
    authenticate_user( Account.select_single(:login_name=>'testcase_conference_reviewer') )
    get :new
    assert_response 401

    authenticate_user( Account.select_single(:login_name=>'testcase_conference_reviewer') )
    get :edit, {:person_id=>1}
    assert_response :success
  end

  def test_person_conference_committee
    authenticate_user( Account.select_single(:login_name=>'testcase_conference_committee') )
    get :new
    assert_response :success

    authenticate_user( Account.select_single(:login_name=>'testcase_conference_committee') )
    get :edit, {:person_id=>1}
    assert_response :success
  end

  def test_new_person
    authenticate_user( Account.select_single(:login_name=>'testcase_conference_committee') )
    get :new
    assert_response :success

    authenticate_user( Account.select_single(:login_name=>'testcase_conference_committee') )
    submit_form('content_form') do | form |
      form.person.first_name = 'Foo'
      form.person.last_name = 'Bar'
    end
    assert_response :redirect
  end
end
