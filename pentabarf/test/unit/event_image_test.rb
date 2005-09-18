require File.dirname(__FILE__) + '/../test_helper'

class EventImageTest < Test::Unit::TestCase
  fixtures :event_images

  def setup
    @event_image = EventImage.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of EventImage,  @event_image
  end
end
