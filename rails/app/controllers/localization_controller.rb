class LocalizationController < ApplicationController

  before_filter :init

  def index
  end

  def ui_message
    constraints = {:translated=>@current_language}
    constraints[:ui_message] = {:ilike=>"#{params[:id]}%"} if params[:id]
    @messages = Ui_message_localized.select(constraints,{:order=>:ui_message})
  end

  def save_ui_message
    params[:ui_message].each do | ui_message, value |
      write_row( Ui_message_localized, value, {:preset=>{:ui_message=>ui_message,:translated=>params[:translated]}})
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
