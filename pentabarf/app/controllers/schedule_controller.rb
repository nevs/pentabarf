class ScheduleController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :compress

  def index

  end
  
  def speaker 
    @content_title = "Speaker and moderators"
    @speaker = Momomoto::View_schedule_person.find({:conference_id=>params[:conference_id]}, nil, 'lower(name)')
  end

  def css
    conference = Momomoto::Conference.find({:conference_id=>params[:conference_id]})
    @response.headers['Content-Type'] = 'text/css'
    render_text(conference.nil? ? "" : conference.css)
  end

  def check_permission
    @conference = Momomoto::Conference.new
    return false unless @conference.select({:conference_id => params[:conference_id]}) == 1
    true
  end

end
