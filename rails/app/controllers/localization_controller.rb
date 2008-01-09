class LocalizationController < ApplicationController

  before_filter :init

  def index
    @content_title = 'Localization'
  end

  def ui_message
    @content_title = 'Localization ui_message'
    @languages = Language.select({:localized=>'t'},{:order=>:language})
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
  end

end
