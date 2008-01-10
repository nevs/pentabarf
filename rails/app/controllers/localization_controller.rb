class LocalizationController < ApplicationController

  before_filter :init

  def index
    @content_title = 'Localization'
  end

  Localization_tables = [:attachment_type,:conference_phase,:event_origin,:event_role,:mime_type,:phone_type,:transport]

  Localization_tables.each do | category |
    define_method(category) do
      @table = category
      @content_title = "Localization #{category}"
      order = category.to_s.capitalize.constantize.columns.key?(:rank) ? :rank : category
      @tags = category.to_s.capitalize.constantize.select({},{:order=>order})
      constraints = {:translated=>@languages.map(&:language)}
      @messages = "#{category}_localized".capitalize.constantize.select(constraints,{:order=>category})
      render(:partial=>'localization_form',:layout=>true)
    end

    define_method("save_#{category}") do
      params[category].each do | category_value, value |
        value.each do | translated, value |
          write_row( "#{category}_localized".capitalize.constantize, value, {:only=>[:name],:preset=>{category=>category_value,:translated=>translated},:ignore_empty=>:name})
        end
      end
      redirect_to( :action => category )
    end

  end

  def ui_message
    @content_title = 'Localization ui_message'
    @tags = Ui_message.select({},{:order=>:ui_message})
    constraints = {:translated=>@languages.map(&:language)}
    constraints[:ui_message] = {:ilike=>"#{params[:id]}%"} if params[:id]
    @messages = Ui_message_localized.select(constraints,{:order=>:ui_message})
  end

  def save_ui_message
    params[:ui_message].each do | ui_message, value |
      value.each do | translated, value |
        write_row( Ui_message_localized, value, {:only=>[:name],:preset=>{:ui_message=>ui_message,:translated=>translated},:ignore_empty=>:name})
      end
    end
    Localizer.purge(params[:translated])
    redirect_to( :action => :ui_message )
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @current_language = POPE.user.current_language
    @languages = Language.select({:localized=>'t'},{:order=>:language})
  end

end
