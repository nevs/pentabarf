class LocalizationController < ApplicationController

  before_filter :init

  def index
  end

  def ui_message
    constraints = {:language_id=>@current_language_id}
    constraints[:ui_message] = {:ilike=>"#{params[:id]}%"} if params[:id]
    @tags = Ui_message_localized.select(constraints,{:order=>:ui_message})
  end

  def save_ui_message
    params[:ui_message].each do | ui_message, value |
      write_row( Ui_message_localized, value, {:preset=>{:ui_message=>ui_message,:language_id=>params[:language_id]}})
    end
    Localizer.purge(params[:language_id])
    redirect_to( :action => :ui_message )
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @current_language_id = POPE.user.current_language_id || 120
  end

end
