class FileController < ApplicationController
  before_filter :authorize
  before_filter :check_permission

  def initialize
    @current_language_id = 144
  end

  def event_attachment
    data = Momomoto::View_event_attachment.find({:event_attachment_id => params[:id], :language_id => @current_language_id})
    file = Momomoto::Event_attachment.find({:event_attachment_id => params[:id]})
    if file.length != 1 || data.length != 1
      render_text("File not found", 404)
      return
    end
    @response.headers['Content-Disposition'] = "attachment; filename=\"#{file.filename}\""
    @response.headers['Content-Type'] = data.mime_type
    @response.headers['Content-Length'] = data.filesize
    @response.headers['Last-Modified'] = file.last_modified
    render_text(file.data)
  end

  protected
  
  def check_permission
    return @user.permission?('pentabarf_login')
  end

end
