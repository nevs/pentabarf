require File.dirname(__FILE__) + '/../test_helper'
require 'xcal_controller'

# Re-raise errors caught by the controller.
class XcalController; def rescue_action(e) raise e end; end

class XcalControllerTest < Test::Unit::TestCase
  def setup
    @controller = XcalController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    hijack_controller_auth( @controller )
    authenticate_user( Person.select_single(:person_id=>1) )
  end

  def teardown
    POPE.deauth
  end

  def test_conference
    get :conference, {:id => 1}
    assert_response :success
  end

end
