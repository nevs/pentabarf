require File.dirname(__FILE__) + '/../test_helper'
require 'submission_controller'

# Re-raise errors caught by the controller.
class SubmissionController; def rescue_action(e) raise e end; end

class SubmissionControllerTest < Test::Unit::TestCase
  def setup
    @controller = SubmissionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @person = Person.new(:login_name=>'test_submitter')
    Person.__write( @person )
    @conference = Conference.select_single(:conference_id=>1)
    Person_role.__write( Person_role.new(:person_id=>@person.person_id,:role=>'submitter') )
  end

  def teardown
    Person.__delete( @person )
    POPE.deauth
  end

  def test_index
    get :index
    assert_response :success
    get :index, :conference => @conference.acronym
    assert_response :success
    authenticate_user( @person )
    get :index
    assert_response :success
    get :index, :conference => @conference.acronym
    assert_response :success
  end

  def test_person
    authenticate_user( @person )
    get :person, :conference => @conference.acronym
    assert_response :success
  end

  def test_event
    authenticate_user( @person )
    get :event, :conference => @conference.acronym
    assert_response :success
  end

  def test_events
    authenticate_user( @person )
    get :events, :conference => @conference.acronym
    assert_response :success
  end

end
