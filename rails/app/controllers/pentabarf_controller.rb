class PentabarfController < ApplicationController
  after_filter :compress
  session(:off)

  def index
    @current_conference = Conference.select_or_new(:conference_id => 1)
  end

  def person
    @current_conference = Conference.select_or_new(:conference_id => 1)
    @person = Person.select_or_new( :person_id => params[:id] )
  end

  def event
    @current_conference = Conference.select_or_new(:conference_id => 1)
    @event = Event.select_or_new( :event_id => params[:id] )
  end

  def conference
    @current_conference = Conference.select_or_new(:conference_id => 1)
    @conference = Conference.select_or_new( :conference_id => params[:id] )
  end

end
