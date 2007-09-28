require File.dirname(__FILE__) + '/../test_helper'
require 'pentabarf_controller'

# Re-raise errors caught by the controller.
class PentabarfController; def rescue_action(e) raise e end; end

class PentabarfControllerTest < Test::Unit::TestCase
  def setup
    @controller = PentabarfController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
    POPE.send( :instance_variable_set, :@user, Person.select_single( :person_id => 1 ) )
  end

  def teardown
    POPE.deauth
  end

  def test_conference
    get :conference, {:id => 1}
    assert_response :success
  end

  def test_event
    get :event, {:id => 6}
    assert_response :success
  end

  def test_person
    get :person, {:id => 1}
    assert_response :success
  end

  def test_review
    get :review
    assert_response :success
  end

  def test_conflicts
    get :conflicts
    assert_response :success
  end

end
