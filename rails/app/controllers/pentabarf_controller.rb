class PentabarfController < ApplicationController

  def activity
    render(:partial=>'activity')
  end

  def index
    @current_conference = Conference.select_single(:conference_id => 2)

  end

end
