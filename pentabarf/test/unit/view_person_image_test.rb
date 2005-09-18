require File.dirname(__FILE__) + '/../test_helper'

class ViewPersonImageTest < Test::Unit::TestCase
  fixtures :view_person_images

  def setup
    @view_person_image = ViewPersonImage.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ViewPersonImage,  @view_person_image
  end
end
