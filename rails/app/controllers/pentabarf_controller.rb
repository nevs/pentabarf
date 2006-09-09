class PentabarfController < ApplicationController
  before_filter :set_conference
  after_filter :compress
  session(:off)

  def index
  end

  def person
    begin
      @person = Person.select_single( :person_id => params[:id].to_i )
    rescue
      return redirect_to(:action=>:person,:id=>'new') if params[:id] != 'new'
      @person = Person.new(:person_id=>0)
    end
  end

  def save_person
    person = Person.select_or_new( {:person_id=>params[:id].to_i},{:copy_values=>false} )
    params[:person].each do | key, value |
      next if key.to_sym == :person_id
      person[key] = value
    end
    person.write
    redirect_to( :action => :person, :id => person.person_id)
  end

  def event
    begin
      @event = Event.select_single( :event_id => params[:id].to_i )
    rescue Momomoto::Nothing_found
      return redirect_to(:action=>:event,:id=>'new') if params[:id] != 'new'
      @event = Event.new(:event_id=>0)
      @event.conference_id = @current_conference.conference_id
    end
    @conference = Conference.select_single(:conference_id=>@event.conference_id)
  end

  def save_event
    Momomoto::Database.instance.transaction do
      event = Event.select_or_new( {:event_id=>params[:id].to_i},{:copy_values=>false} )
      event.conference_id = @current_conference.conference_id if event.new_record?
      params[:event].each do | key, value |
        next if key.to_sym == :event_id
        event[key] = value
      end
      event.write
      params[:event_person].each do | k, v |
        next if k == 'row_id'
        ep = Event_person.select_or_new( :event_person_id => v[:event_person_id].to_i, :event_id => event.event_id )
        ep.event_person_id = nil if ep.new_record?

        if v[:remove]
          ep.delete if not ep.new_record?
        else
          v.each do | field_name, value |
            next if [:event_person_id, :event_id].member?( field_name.to_sym )
            ep[ field_name ] = value
          end
          ep.write
        end
      end
      redirect_to( :action => :event, :id => event.event_id)
    end
  end

  def conference
    begin
      @conference = Conference.select_single( :conference_id => params[:id].to_i )
    rescue
      return redirect_to(:action=>:conference,:id=>'new') if params[:id] != 'new'
      @conference = Conference.new(:conference_id=>0)
    end
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

  [:person, :event, :conference].each do | object |

    define_method("find_#{object}") do end

    define_method("search_#{object}") do
      render(:partial=>"search_#{object}")
    end

  end

  protected
  def set_conference
    @current_conference = Conference.select_or_new(:conference_id => 1)
  end

end

