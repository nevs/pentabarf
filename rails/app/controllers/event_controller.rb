class EventController < ApplicationController

  before_filter :init

  def copy
    cp = Copy_event.call({:source_event_id=>params[:event_id],:target_conference_id=>params[:conference_id],:coordinator_id=>POPE.user.person_id})
    redirect_to({:controller=>'pentabarf',:action=>'event',:id=>cp[0].copy_event})
  end

  def conflicts
    @event = Event.select_single({:event_id=>params[:id]})
    @conflicts = []
    @conflicts += View_conflict_event.call({:conference_id => @event.conference_id},{:event_id=>params[:id],:translated=>@current_language})
    @conflicts += View_conflict_event_event.call({:conference_id => @event.conference_id},{:event_id1=>params[:id],:translated=>@current_language})
    @conflicts += View_conflict_event_person.call({:conference_id => @event.conference_id},{:event_id=>params[:id],:translated=>@current_language})
    @conflicts += View_conflict_event_person_event.call({:conference_id => @event.conference_id},{:event_id1=>params[:id],:translated=>@current_language})
  end

  protected

  def init
    @current_language = POPE.user.current_language || 'en'
  end


end
