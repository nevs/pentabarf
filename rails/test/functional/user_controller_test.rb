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
    token = @response.body.match( /<input [^>]+value="([a-f0-9]{40,40})"/ )
    assert_not_nil token
    token = token[1]
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

end
