
require 'csv'

class CsvController < ApplicationController

  before_filter :init

  def init
    @current_language = POPE.user.current_language || 'en'
  end

  def expenses
    @current_conference = Conference.select_single(:acronym=>params[:id])
    rows = View_report_expenses.select({:conference_id => @current_conference.conference_id})
    header = ['person::name','conference_person_travel::fee','conference_person_travel::fee_currency','conference_person_travel::travel_cost','conference_person_travel::travel_currency','conference_person_travel::accommodation_cost','conference_person_travel::accommodation_currency'].map{|n| local(n)}
    generate_csv( rows, 'expenses.csv', header ) do | d |
      [ d.name, d.fee, d.fee_currency, d.travel_cost, d.travel_currency, d.accommodation_cost, d.accommodation_currency ]
    end
  end

  def feedback
    @current_conference = Conference.select_single(:acronym=>params[:id])
    rows = View_report_feedback.select({:conference_id => @current_conference.conference_id})
    generate_csv( rows, 'feedback.csv' ) do | d |
      [ [d.title,d.subtitle].join(' '), d.comments, d.votes ]
    end
  end

  def paper
    @current_conference = Conference.select_single(:acronym=>params[:id])
    rows = View_report_paper.select({:conference_id => @current_conference.conference_id})
    generate_csv( rows, 'paper.csv' ) do | d |
      [ [d.title,d.subtitle].join(' '), d.paper_submitted > 0 ? 'yes' : 'no', d.pages ]
    end
  end

  def resources
    @current_conference = Conference.select_single(:acronym=>params[:id])
    rows = View_report_resources.select({:conference_id => @current_conference.conference_id})
    header = [local('event::title'),local('event::resources')]
    generate_csv( rows, 'resources.csv', header ) do | d |
      [ [d.title,d.subtitle].join(' '), d.resources ]
    end
  end

  def events
    ids = params[:id].to_s.split(/[ +]+/)
    rows = View_find_event.select({:translated=>POPE.user.current_language,:conference_id=>POPE.user.current_conference_id}.merge( ids.empty? ? {} : {:event_id=>ids} ))
    header = ["ID",local('event::title'),local('schedule::speakers'),local('event::event_state'),local('event::conference_day'),local('event::start_time'),local('event::conference_room'),local('event::duration')]
    generate_csv( rows, 'events.csv', header ) do | d |
      [ d.event_id, [d.title,d.subtitle].join(' '), d.speakers.to_s.split("\n").join(", "), "#{d.event_state} #{d.event_state_progress}", d.conference_day, d.start_time, d.conference_room, d.duration ]
    end
  end

  def persons
    ids = params[:id].to_s.split(/[ +]+/)
    rows = View_find_person.select({:conference_id=>POPE.user.current_conference_id}.merge( ids.empty? ? {} : {:person_id=>ids} ))
    header = ["ID",local('person::name'),local('person::first_name'),local('person::last_name'),local('person::nickname'),local('person::public_name')]
    generate_csv( rows, 'persons.csv', header ) do | d |
      [ d.person_id, d.name, d.first_name, d.last_name, d.nickname, d.public_name ]
    end
  end

  protected

  def check_permission
    return true if POPE.conference_permission?('pentabarf::login',POPE.user.current_conference_id)
    false
  end

  def generate_csv( data, filename, header = nil )
    out = ""
    CSV::Writer.generate( out ) do | csv |
      csv << header if header
      data.each do | d |
        csv << yield( d )
      end
    end
    response.headers['Content-Type'] = Mime::CSV
    response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
    render( :text => out, :layout => false )
  end

end

