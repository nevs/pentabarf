require File.dirname(__FILE__) + '/../test_helper'
require 'atom_controller'

# Re-raise errors caught by the controller.
class AtomController; def rescue_action(e) raise e end; end

class AtomControllerTest < Test::Unit::TestCase
  def setup
    @controller = AtomController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
  end

  def test_recent_changes
    get :recent_changes
    assert_response :success
  end

end
