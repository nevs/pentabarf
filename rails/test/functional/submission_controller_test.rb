require File.dirname(__FILE__) + '/../test_helper'
require 'submission_controller'

# Re-raise errors caught by the controller.
class SubmissionController; def rescue_action(e) raise e end; end

class SubmissionControllerTest < Test::Unit::TestCase
  def setup
    @controller = SubmissionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
    @person = Person.new(:login_name=>'test_submitter')
    Person.__write( @person )
    Person_role.__write( Person_role.new(:person_id=>@person.person_id,:role=>'submitter') )
    POPE.send( :instance_variable_set, :@user, Person.select_single( :person_id => 1 ) )
    POPE.refresh
  end

  def teardown
    Person.__delete( @person )
    POPE.deauth
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
