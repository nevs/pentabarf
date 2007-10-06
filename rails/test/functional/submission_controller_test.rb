require File.dirname(__FILE__) + '/../test_helper'
require 'submission_controller'

# Re-raise errors caught by the controller.
class SubmissionController; def rescue_action(e) raise e end; end

class SubmissionControllerTest < Test::Unit::TestCase
  def setup
    @controller = SubmissionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    hijack_controller_auth( @controller )
    @person = Person.new(:login_name=>'test_submitter')
    Person.__write( @person )
    Person_role.__write( Person_role.new(:person_id=>@person.person_id,:role=>'submitter') )
    authenticate_user( @person )
  end

  def teardown
    Person.__delete( @person )
    POPE.deauth
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test_submission_index
    conf = Conference.select_single(:conference_id=>1)
    get :index
    assert_response :success
    get :index, :conference => conf.acronym
    assert_response :success
  end

end
