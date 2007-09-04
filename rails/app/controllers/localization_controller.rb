class LocalizationController < ApplicationController

  before_filter :init

  def index
  end

  def ui_message
    constraints = {:language_id=>@current_language_id}
    constraints[:tag] = {:ilike=>"#{params[:id]}%"} if params[:id]
    @tags = View_ui_message.select(constraints,{:order=>:tag})
  end

  def save_ui_message
    params[:ui_message].each do | ui_message_id, value |
      write_row( Ui_message_localized, value, {:preset=>{:ui_message_id=>ui_message_id,:language_id=>params[:language_id]}})
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
