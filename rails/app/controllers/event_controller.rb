class EventController < ApplicationController

  def copy
    cp = Copy_event.call({:source_event_id=>params[:event_id],:target_conference_id=>params[:conference_id],:coordinator_id=>POPE.user.person_id})
    redirect_to({:controller=>'pentabarf',:action=>'event',:id=>cp[0].copy_event})
  end

end
