require File.dirname(__FILE__) + '/../test_helper'

class ViewLastActiveTest < Test::Unit::TestCase
  fixtures :view_last_actives

  def setup
    @view_last_active = ViewLastActive.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ViewLastActive,  @view_last_active
  end
end
