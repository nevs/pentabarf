require File.dirname(__FILE__) + '/../test_helper'
require 'pentabarf_controller'

# Re-raise errors caught by the controller.
class PentabarfController; def rescue_action(e) raise e end; end

class PentabarfControllerTest < Test::Unit::TestCase

  def setup
    @controller = PentabarfController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
  end

  def test_person
    sven = Person.select_or_new(:person_id=>1)
    sven.first_name = 'sven'
    sven.write
    get :person, {:id => 1}
    assert_response :success
  end

  def test_new_person
    get :person, {:id => 'new'}
    assert_response :success
    get :person, {:id => 0}
    assert_response :redirect
    assert_redirected_to :action => :person, :id => 'new'
  end

  def test_event
    get :event, {:id => 1}
    assert_response :success
  end

  def test_new_event
    get :event, {:id => 'new'}
    assert_response :success
    get :event, {:id => 0}
    assert_response :redirect
    assert_redirected_to :action => :event, :id => 'new'
  end

  def test_conference
    conf = Conference.new
    conf.acronym = 'Pentabarf' + rand.to_s
    conf.title = 'Pentabarf Developer Conference'
    conf.conference_phase = 'chaos'
    conf.start_date = '2007-08-07'
    conf.write
    get :conference, {:id => conf.conference_id}
    assert_response :success
    conf.delete
  end

  def test_new_conference
    get :conference, {:id => 'new'}
    assert_response :success
    get :conference, {:id => 0}
    assert_response :redirect
    assert_redirected_to :action => :conference, :id => 'new'
  end

end

