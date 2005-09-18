require File.dirname(__FILE__) + '/../test_helper'

class ViewRecentChangesTest < Test::Unit::TestCase
  fixtures :view_recent_changes

  def setup
    @view_recent_changes = ViewRecentChanges.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ViewRecentChanges,  @view_recent_changes
  end
end
