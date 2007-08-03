class LocalizationController < ApplicationController

  before_filter :init

  def index
  end

  def ui_message
    @tags = View_ui_message.select({:language_id=>@current_language_id},{:order=>:tag})
  end

  def save_ui_message
    params[:ui_message].each do | ui_message_id, value |
      write_row( Ui_message_localized, value, {:preset=>{:ui_message_id=>ui_message_id,:language_id=>params[:language_id]}})
    end
    redirect_to( :action => :ui_message )
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    # FIXME: remove hardcoded language
    @current_language_id = 120
    @token = generate_token( url_for() )
  end

end
