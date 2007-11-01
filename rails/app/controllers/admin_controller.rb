class AdminController < ApplicationController

  before_filter :init

  def index
  end

  def conflict_setup
    @phases = Conference_phase_localized.select(:language_id=>@current_language_id)
    @conflicts = Conflict_localized.select({:language_id=>@current_language_id})
    @level = Conflict_level_localized.select(:language_id=>@current_language_id).map{|l|[l.conflict_level,l.name]}
    @phase_conflicts = Conference_phase_conflict.select
  end

  def save_conflict_setup
    params[:conflict].each do | conflict_id, outer |
      outer.each do | conference_phase, value |
        write_row( Conference_phase_conflict, value, {:preset=>{:conflict_id=>conflict_id,:conference_phase=>conference_phase}})
      end
    end
    redirect_to( :action => :conflict_setup )
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @current_language_id = POPE.user.current_language_id || 120
  end

end
