require File.dirname(__FILE__) + '/../test_helper'
require 'submission_controller'

# Re-raise errors caught by the controller.
class SubmissionController; def rescue_action(e) raise e end; end

class SubmissionControllerTest < Test::Unit::TestCase
  def setup
    @controller = SubmissionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user = Account.new(:login_name=>'test_submitter',:email=>'test@localhost',:current_language=>'en',:person_id=>1)
    Account.__write( @user )
    @conference = Conference.select_single(:conference_id=>1)
    Account_role.__write( Account_role.new(:account_id=>@user.account_id,:role=>'submitter') )
  end

  def teardown
    Account.__delete( @user )
    POPE.deauth
  end

  def test_index
    get :index
    assert_response :success
    get :index, :conference => @conference.acronym
    assert_response :success
    authenticate_user( @user )
    get :index
    assert_response :success
    get :index, :conference => @conference.acronym
    assert_response :success
  end

  def test_person
    authenticate_user( @user )
    get :person, :conference => @conference.acronym
    assert_response :success
  end

  def test_event
    authenticate_user( @user )
    get :event, :conference => @conference.acronym
    assert_response :success
    authenticate_user( @user )
    submit_form do | form |
      form.event.title = 'Event Submission Test'
    end
    assert_response :redirect
  end

  def test_events
    authenticate_user( @user )
    get :events, :conference => @conference.acronym
    assert_response :success
  end

end
