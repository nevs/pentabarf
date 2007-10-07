require File.dirname(__FILE__) + '/../test_helper'
require 'user_controller'

# Re-raise errors caught by the controller.
class UserController; def rescue_action(e) raise e end; end

class UserControllerTest < Test::Unit::TestCase
  def setup
    @controller = UserController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_account_creation_and_activation
    get :new_account
    assert_response :success
    token = extract_token( @response.body )
    assert_not_nil token
    post :save_account, {:token=>token,:person=>{:login_name=>'chunky',:email_contact=>'chunky@bacon.com',:password=>'bacon'},:password=>'bacon'}
    assert_response :redirect
    assert_redirected_to( :action => :account_done)
    chunky = Person.select_single(:login_name=>'chunky')
    active = Account_activation.select_single(:person_id=>chunky.person_id)
    get :activate_account, :id=>active.activation_string
    assert_response :redirect
    assert_redirected_to( :controller => 'submission' )
    assert_equal( 1, Person_role.select(:person_id=>chunky.person_id).length )
    Person.__delete( chunky )
  end

  def test_resetting_password
    user = Person.new(:login_name=>'test_password_reset',:email_contact=>'sven@pentabarf.org')
    Person.__write( user )
    get :forgot_password
    assert_response :success
    token = extract_token( @response.body )
    assert_not_nil token
    post :save_forgot_password, {:token=>token,:login_name=>'test_password_reset',:email=>'sven@pentabarf.org'}
    assert_response :redirect
    get :reset_link_sent
    assert_response :success
    id = Password_reset_string.select_single(:person_id=>user.person_id)
    get :reset_password, :id=>id.activation_string
    assert_response :success
    token = extract_token( @response.body )
    post :save_reset_password, :id=>id.activation_string,:password=>'newpass',:password2=>'newpass',:token=>token
    assert_response :redirect
    assert_not_equal( user.password, Person.select_single(:person_id=>user.person_id).password )
    Person.__delete( user )
  end

end
