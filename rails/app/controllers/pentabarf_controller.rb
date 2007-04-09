class PentabarfController < ApplicationController
  
  before_filter :init

  def index
  end

  def conference
    @conference = Conference.select_single(:conference_id => 2)
  end

  def activity
    @last_active = View_last_active.select( {:login_name => {:ne => @user.login_name}}, {:limit => 12} )
    render(:partial=>'activity')
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => 2)
  end

end
