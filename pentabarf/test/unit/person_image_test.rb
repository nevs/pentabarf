require File.dirname(__FILE__) + '/../test_helper'

class PersonImageTest < Test::Unit::TestCase
  fixtures :person_images

  def setup
    @person_image = PersonImage.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of PersonImage,  @person_image
  end
end
