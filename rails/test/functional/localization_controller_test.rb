require File.dirname(__FILE__) + '/../test_helper'
require 'localization_controller'

# Re-raise errors caught by the controller.
class LocalizationController; def rescue_action(e) raise e end; end

class LocalizationControllerTest < Test::Unit::TestCase

  def setup
    @controller = LocalizationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    authenticate_user( Account.select_single(:login_name=>'admin') )
  end

  def teardown
    POPE.deauth
  end

  def test_index
    get :index
    assert_response :success
  end

  LocalizationController::Localization_tables.each do | table |
    define_method( "test_#{table}" ) do
      get table
      assert_response :success
    end
  end

end
