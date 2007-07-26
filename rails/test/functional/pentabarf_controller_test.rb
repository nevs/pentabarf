require File.dirname(__FILE__) + '/../test_helper'
require 'pentabarf_controller'

# Re-raise errors caught by the controller.
class PentabarfController; def rescue_action(e) raise e end; end

class PentabarfControllerTest < Test::Unit::TestCase
  def setup
    @controller = PentabarfController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # test auth for all public methods
  PentabarfController.action_methods.each do | method |
    define_method "test_auth_#{method}" do
      get method
      assert_response 401
    end
  end

  def test_conference
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
    POPE.send( :instance_variable_set, :@user, Person.select_single( :login_name => 'sven' ) )
    get :conference, {:id => 1}
    assert_response :success
    POPE.deauth
  end

  def test_event
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
    POPE.send( :instance_variable_set, :@user, Person.select_single( :login_name => 'sven' ) )
    get :event, {:id => 6}
    assert_response :success
    POPE.deauth
  end

  def test_person
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
    POPE.send( :instance_variable_set, :@user, Person.select_single( :login_name => 'sven' ) )
    get :person, {:id => 1}
    assert_response :success
    POPE.deauth
  end

end
