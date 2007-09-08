require File.dirname(__FILE__) + '/../test_helper'
require 'report_controller'

# Re-raise errors caught by the controller.
class ReportController; def rescue_action(e) raise e end; end

class ReportControllerTest < Test::Unit::TestCase
  def setup
    @controller = ReportController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
    POPE.instance_variable_set( :@user, Person.select_single(:person_id=>1) )
  end

  def test_expenses
    get :expenses
    assert_response :success
  end

  def test_feedback
    get :feedback
    assert_response :success
  end

end
