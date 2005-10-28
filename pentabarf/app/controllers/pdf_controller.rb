class PdfController < ApplicationController
  before_filter :authorize, :check_permission

  def check_permission
    #redirect_to :action => :meditation if params[:action] != 'meditation'
    if @user.permission?('login_allowed') 
      @preferences = @user.preferences
      @current_conference_id = @preferences[:current_conference_id]
      @current_language_id = @preferences[:current_language_id]
    else
      redirect_to(:controller =>'pentabarf', :action => :meditation )
      false
    end
  end

  def pentacards
      #search_event()  
      pc = Pentacards.new(@events,2,2)
      send_data(pc.render, :filename => 'pentacards.pdf', :type => 'application/pdf', :disposition => 'attachment')		    
  end
end
