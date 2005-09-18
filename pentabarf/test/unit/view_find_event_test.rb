require File.dirname(__FILE__) + '/../test_helper'

class ViewFindEventTest < Test::Unit::TestCase
  fixtures :view_find_events

  def setup
    @view_find_event = ViewFindEvent.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ViewFindEvent,  @view_find_event
  end
end
