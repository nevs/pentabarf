class FileController < ApplicationController

  def initialize
    @current_language = 'en'
  end

  def event_attachment
    data = View_event_attachment.select_single({:event_attachment_id => params[:id], :translated => @current_language})
    file = Event_attachment.select_single({:event_attachment_id => params[:id]})
    response.headers['Content-Disposition'] = "attachment; filename=\"#{file.filename}\""
    response.headers['Content-Type'] = data.mime_type
    response.headers['Content-Length'] = data.filesize
#    response.headers['Last-Modified'] = file.last_modified
    render_text(file.data)
   rescue
    render_text("File not found", 404)
  end

end
