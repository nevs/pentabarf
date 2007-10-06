require File.dirname(__FILE__) + '/../test_helper'
require 'report_controller'

# Re-raise errors caught by the controller.
class ReportController; def rescue_action(e) raise e end; end

class ReportControllerTest < Test::Unit::TestCase
  def setup
    @controller = ReportController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    hijack_controller_auth( @controller )
    authenticate_user( Person.select_single(:person_id=>1) )
  end

  def teardown
    POPE.deauth
  end

  [:expenses,:feedback,:resources].each do | action |
    define_method "test_#{action}" do
      get action
      assert_response :success
    end
  end

end
