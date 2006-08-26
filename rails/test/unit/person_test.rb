require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < Test::Unit::TestCase

  def test_crud
    sven = Person.new
    sven.first_name = 'Sven'
    sven.last_name = 'Klemm'
    sven.write
    assert 1 == Person.select(:person_id => sven.person_id).length

    sven.last_name = 'chunky'
    sven.write

    sven2 = Person.select(:person_id=>sven.person_id)
    assert 'chunky' == sven2.last_name

    sven.delete
    assert 0 == Person.select(:person_id => sven.person_id).length
  end

end
