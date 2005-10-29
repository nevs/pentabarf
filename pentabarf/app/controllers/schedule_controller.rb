class ScheduleController < ApplicationController

  def speaker 
    @speaker = Momomoto::View_schedule_person.find({:conference_id=>conference_id})
  end

end
