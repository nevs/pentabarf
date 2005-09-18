require File.dirname(__FILE__) + '/../test_helper'

class ConferenceImageTest < Test::Unit::TestCase
  fixtures :conference_images

  def setup
    @conference_image = ConferenceImage.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ConferenceImage,  @conference_image
  end
end
