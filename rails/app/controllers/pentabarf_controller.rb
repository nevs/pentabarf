class PentabarfController < ApplicationController
  before_filter :set_conference
  after_filter :compress
  session(:off)

  def index
  end

  def person
    @person = Person.select_or_new( :person_id => params[:id].to_i )
  end

  def event
    @event = Event.select_or_new( :event_id => params[:id].to_i )
  end

  def conference
    @conference = Conference.select_or_new( :conference_id => params[:id].to_i )
  end

  def save_conference
    conference = Conference.select_or_new( {:conference_id=>params[:id]},{:copy_values=>false} )
    params[:conference].each do | key, value |
      next if key.to_sym == :conference_id
      conference[key] = value
    end
    conference.write
    redirect_to( :action => :conference, :id => conference.conference_id)
  end

  protected
  def set_conference
    @current_conference = Conference.select_or_new(:conference_id => 1)
  end

end

