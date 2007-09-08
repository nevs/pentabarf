require File.dirname(__FILE__) + '/../test_helper'
require 'xml_controller'

# Re-raise errors caught by the controller.
class XmlController; def rescue_action(e) raise e end; end

class XmlControllerTest < Test::Unit::TestCase
  def setup
    @controller = XmlController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @controller.send( :instance_eval ) { class << self; self; end }.send(:define_method, :auth ) do true end
    POPE.instance_variable_set( :@user, Person.select_single(:person_id=>1) )
  end

  def test_schedule
    get :schedule, {:id=>1}
    assert_response :success
  end

end
