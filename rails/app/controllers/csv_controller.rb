
require 'csv'

class CsvController < ApplicationController

  def expenses
    @current_conference = Conference.select_single(:acronym=>params[:id])
    rows = View_report_expenses.select({:conference_id => @current_conference.conference_id})
    generate_csv( rows, 'expenses.csv' ) do | d |
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
    generate_csv( rows, 'resources.csv' ) do | d |
      [ [d.title,d.subtitle].join(' '), d.resources ]
    end
  end

  protected

  def generate_csv( data, filename )
    out = ""
    CSV::Writer.generate( out ) do | csv |
      data.each do | d |
        csv << yield( d )
      end
    end
    response.headers['Content-Type'] = 'text/csv'
    response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
    render( :text => out, :layout => false )
  end

end

