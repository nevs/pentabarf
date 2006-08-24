class Symbol
  def r2x
    to_s.gsub('_', '-').intern
  end
end
class Builder::XmlMarkup
  def _start_tag(sym, attrs, end_too=false)
    @target << "<#{sym.r2x}"
    attrs_x = {}
    (attrs || {}).each { |k,v|
      attrs_x[k.r2x] = v
    }
    _insert_attributes(attrs_x)
    @target << "/" if end_too
    @target << ">"
  end
  def _end_tag(sym)
    @target << "</#{sym.r2x}>"
  end
end

class PdfController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :fop_process

  def conference
    @conference = Momomoto::Conference.find({:conference_id => params[:id]})
    @rooms = Momomoto::View_room.find({:conference_id=>@current_conference_id, :language_id=>@current_language_id})
    @events = Momomoto::View_schedule_event.find({:conference_id => @conference.conference_id, :translated_id => @current_language_id})

    @page_width = '210mm'
    @page_height = '297mm'
    @margin_top = '20mm'
    @margin_bottom = '20mm'
    @margin_left = '20mm'
    @margin_right = '20mm'
    @column_width_time = '10mm'
    @column_width_event = '40mm'
  end

  def fop_process
    fo = Tempfile.new('PdfController')
    pdf_path = "#{fo.path}.pdf"
    fo.write @response.body
    fo.flush

    fop_output = `/usr/local/src/fop/fop -fo #{fo.path} -pdf #{pdf_path} 2>&1`

    fo.close

    begin
      @response.body = IO::readlines(pdf_path) { |pdf| pdf.readlines.to_s }
      @response.headers['Content-type'] = 'application/pdf'
      $stderr.puts fop_output
    rescue SystemCallError
      @response.body = fop_output
      @response.headers['Content-type'] = 'text/plain'
    end
    begin
      File.unlink(pdf_path)
    rescue SystemCallError
    end
  end

  protected

  def check_permission
    #redirect_to :action => :meditation if params[:action] != 'meditation'
    if @user.permission?('pentabarf_login') || params[:action] == 'meditation'
      @preferences = @user.preferences
      @current_conference_id = @preferences[:current_conference_id]
      @current_language_id = @preferences[:current_language_id]
      return true
    end
    redirect_to( :action => :meditation )
    false
  end

end
