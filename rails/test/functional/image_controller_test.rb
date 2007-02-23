require File.dirname(__FILE__) + '/../test_helper'
require 'image_controller'
require 'digest/md5'

# Re-raise errors caught by the controller.
class ImageController; def rescue_action(e) raise e end; end

class ImageControllerTest < Test::Unit::TestCase
  def setup
    @person = Person.new( :login_name => 'user', :password => Digest::MD5.hexdigest( 'pass' ), :salt => '' )
    @person.write
    @controller = ImageController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def teardown
    @person.delete
  end

  def test_auth
    PentabarfController.instance_methods( false ).each do | method |
      get method
      assert_response 401
    end
    PentabarfController.instance_methods( false ).each do | method |
      get method
      assert_response 401
    end
  end

  def test_person
    get :person, {:id => 1}, { "Authorization" => Base64.encode64("user:pass").chomp }
    assert_response :success
  end

  def test_event
    get :event, {:id => 1}, { "Authorization" => Base64.encode64("user:pass").chomp }
    assert_response :success
  end

  def test_conference
    get :conference, {:id => 1}, { "Authorization" => Base64.encode64("user:pass").chomp }
    assert_response :success
  end

end

