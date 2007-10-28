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
    begin
      get :new_account
      assert_response :success
      submit_form do | form |
        form.person.login_name = 'chunky'
        form.person.email_contact = 'chunky@bacon.com'
        form.person.password = 'bacon'
        form.password = 'bacon'
      end
      assert_response :redirect
      assert_redirected_to( :action => :account_done)
      chunky = Person.select_single(:login_name=>'chunky')
      active = Account_activation.select_single(:person_id=>chunky.person_id)
      get :activate_account, :id=>active.activation_string
      assert_response :redirect
      assert_redirected_to( :controller => 'submission' )
      assert_equal( 1, Person_role.select(:person_id=>chunky.person_id).length )
    ensure
      Person.__delete( chunky )
    end
  end

  def test_resetting_password
    user = Person.new(:login_name=>'test_password_reset',:email_contact=>'sven@pentabarf.org')
    Person.__write( user )
    get :forgot_password
    assert_response :success
    submit_form do | form |
      form.login_name = 'test_password_reset'
      form.email = 'sven@pentabarf.org'
    end
    assert_response :redirect
    get :reset_link_sent
    assert_response :success
    id = Password_reset_string.select_single(:person_id=>user.person_id)
    get :reset_password, :id=>id.activation_string
    assert_response :success
    submit_form do | form |
      form.password = 'newpass'
      form.password2 = 'newpass'
    end
    assert_response :redirect
    assert_not_equal( user.password, Person.select_single(:person_id=>user.person_id).password )
    Person.__delete( user )
  end

end
