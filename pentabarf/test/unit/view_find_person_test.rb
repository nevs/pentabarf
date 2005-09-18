require File.dirname(__FILE__) + '/../test_helper'

class ViewFindPersonTest < Test::Unit::TestCase
  fixtures :view_find_people

  def setup
    @view_find_person = ViewFindPerson.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ViewFindPerson,  @view_find_person
  end
end
