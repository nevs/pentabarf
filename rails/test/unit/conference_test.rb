require File.dirname(__FILE__) + '/../test_helper'

class ConferenceTest < Test::Unit::TestCase

  def test_crud
    conf = Conference.new
    conf.acronym = 'Pentabarf'
    conf.title = 'Pentabarf Developer Conference'
    conf.conference_phase = 'chaos'
    conf.start_date = '07.08.1978'
    conf.write
    assert 1 == Conference.select(:conference_id => conf.conference_id).length

    conf.title = 'Chunky Bacon'
    conf.write

    conf2 = Conference.select(:conference_id => conf.conference_id)
    assert 'Chunky Bacon' == conf2.title

    conf.delete
    assert 0 == Conference.select(:conference_id => conf.conference_id).length
  end

end
