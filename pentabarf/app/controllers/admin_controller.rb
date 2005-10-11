class AdminController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :compress


  def index
  end

  def conflict
    @content_title = 'Conflict Setup'
  end


  protected

    def check_permission
      if @user.permission?('login_allowed') || params[:action] == 'meditation'
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
