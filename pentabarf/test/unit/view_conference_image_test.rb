require File.dirname(__FILE__) + '/../test_helper'

class ViewConferenceImageTest < Test::Unit::TestCase
  fixtures :view_conference_images

  def setup
    @view_conference_image = ViewConferenceImage.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ViewConferenceImage,  @view_conference_image
  end
end
