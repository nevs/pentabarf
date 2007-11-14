class AdminController < ApplicationController

  before_filter :init

  def index
  end

  def conflict_setup
    @phases = Conference_phase_localized.select(:translated=>@current_language)
    @conflicts = Conflict_localized.select({:translated=>@current_language})
    @level = Conflict_level_localized.select(:translated=>@current_language).map{|l|[l.conflict_level,l.name]}
    @phase_conflicts = Conference_phase_conflict.select
  end

  def save_conflict_setup
    params[:conflict].each do | conflict, outer |
      outer.each do | conference_phase, value |
        write_row( Conference_phase_conflict, value, {:preset=>{:conflict=>conflict,:conference_phase=>conference_phase}})
      end
    end
    redirect_to( :action => :conflict_setup )
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @current_language = POPE.user.current_language
  end

end
