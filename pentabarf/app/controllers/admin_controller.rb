class AdminController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :compress

  def initialize
    super
    @allowed_classes = ['conflict', 'transport', 'ui_message']
  end
  
  def index
  end

  def conflict
    @content_title = 'Conflict Setup'
  end

  def localization
    @content_title = 'Localization'
    get_localization_classes(params[:id])

    @languages = Momomoto::View_language.find({:language_id => @current_language_id, :f_localized => 't'})
    @localization = []
    for lang in @languages 
      @localization[lang.translated_id] = @localization_class.find({:language_id => lang.translated_id})
    end 
  end

  def save_localization
    get_localization_classes(params[:id])
    message = @localization_class.new
    params[:localization].each do | id , values |
      values.each do | language_id, value |
        message.select({@localization_id => id, :language_id => language_id})
        if message.length == 1
          if value.to_s == '' 
            message.delete
            next
          end
        else
          next if value.to_s == ''
          message.create
          message[@localization_id]= id 
          message.language_id = language_id
        end
        message.name = value
        message.write
      end
    end
    redirect_to :action => :localization, :id => params[:id]
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

    def get_localization_classes( tag )
      raise "Localization for this table is not allowed" unless @allowed_classes.member?(tag)
      @tag_class = eval "Momomoto::#{tag.capitalize}"
      @localization_class = eval("Momomoto::#{tag.capitalize}_localized")
      @localization_id = "#{tag}_id".to_sym
    end

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
