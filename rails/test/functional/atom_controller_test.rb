require File.dirname(__FILE__) + '/../test_helper'
require 'atom_controller'

# Re-raise errors caught by the controller.
class AtomController; def rescue_action(e) raise e end; end

class AtomControllerTest < ActionController::TestCase
  def setup
    @controller = AtomController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    authenticate_user( Account.select_single(:login_name=>'committee') )
  end

  def test_recent_changes
    get :recent_changes
    assert_response :success
  end

end
