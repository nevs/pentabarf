class AdminController < ApplicationController

  before_filter :init

  def index
  end

  def conflict_setup
    @phases = View_conference_phase.select(:language_id=>@current_language_id)
    @conflicts = View_conflict.select({:language_id=>@current_language_id})
    @level = View_conflict_level.select(:language_id=>@current_language_id).map{|l|[l.conflict_level_id,l.name]}
    @phase_conflicts = Conference_phase_conflict.select
  end

  def save_conflict_setup
    params[:conflict].each do | conflict_id, outer |
      outer.each do | conference_phase_id, value |
        write_row( Conference_phase_conflict, value, {:preset=>{:conflict_id=>conflict_id,:conference_phase_id=>conference_phase_id}})
      end
    end
    redirect_to( :action => :conflict_setup )
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    # FIXME: remove hardcoded language
    @current_language_id = 120
  end

end
