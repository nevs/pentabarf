require File.dirname(__FILE__) + '/../test_helper'

class ViewPersonTest < Test::Unit::TestCase
  fixtures :view_people

  def setup
    @view_person = ViewPerson.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ViewPerson,  @view_person
  end
end
