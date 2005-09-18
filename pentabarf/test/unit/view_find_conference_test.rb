require File.dirname(__FILE__) + '/../test_helper'

class ViewFindConferenceTest < Test::Unit::TestCase
  fixtures :view_find_conferences

  def setup
    @view_find_conference = ViewFindConference.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ViewFindConference,  @view_find_conference
  end
end
