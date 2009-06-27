require File.dirname(__FILE__) + '/../test_helper'
require 'pentabarf_controller'

# Re-raise errors caught by the controller.
class PentabarfController; def rescue_action(e) raise e end; end

class PentabarfControllerTest < Test::Unit::TestCase
  def setup
    @controller = PentabarfController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    authenticate_user( Account.select_single(:login_name=>'committee') )
  end

  def teardown
    POPE.deauth
  end

  [:conflicts,:recent_changes,:schedule,:find_person,:find_event,:find_conference].each do | action |
    define_method "test_#{action}" do
      get action
      assert_response :success
    end
  end

end
