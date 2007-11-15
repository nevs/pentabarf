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
    login_name = 'account_creation_test'
    chunky = nil
    begin
      get :new_account
      assert_response :success
      submit_form do | form |
        form.account.login_name = login_name
        form.account.email = 'chunky@bacon.com'
        form.account.password = 'bacon'
        form.password = 'bacon'
      end
      assert_response :redirect
      assert_redirected_to( :action => :account_done)
      chunky = Account.select_single(:login_name=>login_name)
      active = Account_activation.select_single(:account_id=>chunky.account_id)
      get :activate_account, :id=>active.activation_string
      assert_response :redirect
      assert_redirected_to( :controller => 'submission' )
      assert_equal( 1, Account_role.select(:account_id=>chunky.account_id).length )
    ensure
      Account.__delete( chunky ) if chunky
    end
  end

  def test_resetting_password
    begin
      user = Account.new(:login_name=>'test_password_reset',:email=>'sven@pentabarf.org')
      Account.__write( user )
      get :forgot_password
      assert_response :success
      submit_form do | form |
        form.login_name = 'test_password_reset'
        form.email = 'sven@pentabarf.org'
      end
      assert_response :redirect
      get :reset_link_sent
      assert_response :success
      id = Account_password_reset.select_single(:account_id=>user.account_id)
      get :reset_password, :id=>id.activation_string
      assert_response :success
      submit_form do | form |
        form.password = 'newpass'
        form.password2 = 'newpass'
      end
      assert_response :redirect
      assert_not_equal( user.password, Account.select_single(:account_id=>user.account_id).password )
    ensure
      Account.__delete( user )
    end
  end

end
