require File.dirname(__FILE__) + '/../test_helper'
require 'schedule_controller'

# Re-raise errors caught by the controller.
class ScheduleController; def rescue_action(e) raise e end; end

class ScheduleControllerTest < Test::Unit::TestCase
  def setup
    @controller = ScheduleController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    authenticate_user( Account.select_single(:login_name=>'testcase_committee') )
    get :index, {:conference=>'TEST'}
    assert_response :success
  end

  def test_speakers
    authenticate_user( Account.select_single(:login_name=>'testcase_committee') )
    get :speakers, {:conference=>'TEST'}
    assert_response :success
  end

  def test_events
    authenticate_user( Account.select_single(:login_name=>'testcase_committee') )
    get :events, {:conference=>'TEST'}
    assert_response :success
  end

  def test_days
    c = Conference.select_single({:acronym=>:TEST})
    c.days.each do | day |
      authenticate_user( Account.select_single(:login_name=>'testcase_committee') )
      get :day, {:id=>day.conference_day.to_s,:conference=>'TEST'}
      assert_response :success
    end
  end

end
