require File.dirname(__FILE__) + '/../test_helper'

class PentacardsTest < Test::Unit::TestCase

  def test_pentacards_generation
    conference = Conference.select_single({:conference_id=>1})
    events = View_event.select({:translated => 'en', :conference_id => conference.conference_id})
    pc = Pentacards.new( events, 2, 2 )
    pc.render
  end

end
