class XmlController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :save_preferences, :except => [:meditation, :activity, :save_conference, :save_event, :save_person]
  after_filter :compress

  def check_permission
    #redirect_to :action => :meditation if params[:action] != 'meditation'
    if @user.permission?('pentabarf_login') || params[:action] == 'meditation'
      @preferences = @user.preferences.dup
      @current_conference_id = @preferences[:current_conference_id]
      @current_language_id = @preferences[:current_language_id]
      return true
    end
    redirect_to( :controller => 'pentabarf', :action => :meditation )
    false
  end

  def schedule
    @conference = Momomoto::Conference.find({:conference_id => @params[:id]})
    @rooms = Momomoto::View_room.find({:conference_id=>@conference.conference_id, :language_id=>@current_language_id, :f_public=>'t'}, nil, 'rank')
    @events = Momomoto::View_schedule_event.find({:conference_id=>@conference.conference_id,:translated_id=>@current_language_id}, nil, 'lower(title),lower(subtitle)' )
  end

end
