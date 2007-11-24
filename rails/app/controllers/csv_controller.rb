
require 'csv'

class CsvController < ApplicationController

  def resources
    @current_conference = Conference.select_single(:acronym=>params[:id])
    resources = View_report_resources.select({:conference_id => @current_conference.conference_id})
    generate_csv( resources, 'resources.csv' ) do | d |
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

