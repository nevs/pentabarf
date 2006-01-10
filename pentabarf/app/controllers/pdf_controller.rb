class PdfController < ApplicationController
  before_filter :authorize, :check_permission

  def pentacards
      #search_event()  
      pc = Pentacards.new(@events,2,2)
      send_data(pc.render, :filename => 'pentacards.pdf', :type => 'application/pdf', :disposition => 'attachment')    
  end

  protected
  
  def check_permission
    false
  end

end
