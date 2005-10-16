class AdminController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :compress


  def index
  end

  def conflict
    @content_title = 'Conflict Setup'
  end

  def localization

  end

  def save_conflict
    phase_conflict = Momomoto::Conference_phase_conflict.new
    params[:conference_phase_conflict].each do | phase_id, value |
      value.each do | conflict_id, level |
        phase_conflict.find({:conference_phase_id=>phase_id, :conflict_id=>conflict_id})
        if phase_conflict.nil?
          phase_conflict.create
          phase_conflict.conference_phase_id = phase_id
          phase_conflict.conflict_id = conflict_id
        end
        phase_conflict.conflict_level_id = level
        phase_conflict.write
      end
    end
    redirect_to({:action => :conflict})
  end

  protected

    def check_permission
      if @user.permission?('admin_login') || params[:action] == 'meditation'
        @preferences = @user.preferences
        if params[:current_conference_id]
          conf = Momomoto::Conference.find({:conference_id => params[:current_conference_id]})
          if conf.length == 1
            @preferences[:current_conference_id] = params[:current_conference_id].to_i
            @user.preferences = @preferences
            @user.write
            redirect_to
            return false
          end
        end
        @current_conference_id = @preferences[:current_conference_id]
        @current_language_id = @preferences[:current_language_id]
      else
        redirect_to( :action => :meditation )
        false
      end
    end

end
