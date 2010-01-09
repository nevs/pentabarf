require File.dirname(__FILE__) + '/../test_helper'
require 'report_controller'

# Re-raise errors caught by the controller.
class ReportController; def rescue_action(e) raise e end; end

class ReportControllerTest < ActionController::TestCase
  def setup
    @controller = ReportController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def teardown
    POPE.deauth
  end

  ReportController::REPORTS.each do | action |
    define_method "test_submitter_#{action}" do
      authenticate_user( Account.select_single(:login_name=>'testcase_submitter') )
      get action
      assert_response 401
    end

    define_method "test_committee_#{action}" do
      authenticate_user( Account.select_single(:login_name=>'testcase_committee') )
      get action
      assert_response :success
    end

    define_method "test_conference_committee_#{action}" do
      authenticate_user( Account.select_single(:login_name=>'testcase_conference_committee') )
      get action
      assert_response :success
    end
  end

end
