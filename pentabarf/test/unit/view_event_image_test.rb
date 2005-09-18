require File.dirname(__FILE__) + '/../test_helper'

class ViewEventImageTest < Test::Unit::TestCase
  fixtures :view_event_images

  def setup
    @view_event_image = ViewEventImage.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ViewEventImage,  @view_event_image
  end
end
