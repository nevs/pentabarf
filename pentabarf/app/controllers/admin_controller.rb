class AdminController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :compress

  def index
  end

  def conflict
    @content_title = 'Conflict Setup'
  end

  def localization
    @content_title = 'Localization'
    @languages = Momomoto::View_language.find({:language_id => @current_language_id, :f_localized => 't'})
    @tag_class = Momomoto::Ui_message.new
    @localization_class = Momomoto::Ui_message_localized.new
    @localization_id = :ui_message_id
    @localization = []
    for lang in @languages 
      @localization[lang.translated_id] = @localization_class.find({:language_id => lang.translated_id})
    end 
  end

  def save_localization

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
        @current_conference_id = @preferences[:current_conference_id]
        @current_language_id = @preferences[:current_language_id]
      else
        redirect_to( :action => :meditation )
        false
      end
    end

end
