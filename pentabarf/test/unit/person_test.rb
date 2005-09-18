require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < Test::Unit::TestCase
  fixtures :people

  def setup
    @person = Person.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Person,  @person
  end
end
