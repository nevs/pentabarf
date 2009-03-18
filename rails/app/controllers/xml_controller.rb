class XmlController < ApplicationController

  before_filter :init

  def schedule
    if params[:preview]
      # if preview is specified we work on live data
      @conference = Release_preview::Conference.select_single({:acronym=>params[:conference]})
    elsif params[:release]
      # if a specific release is selected we show that one
      @conference = Release::Conference.select_single({:acronym=>params[:conference],:conference_release_id=>params[:release]})
    else
      # otherwise we show the latest release with fallback to live data if nothing has been released yet
      begin
        @conference = Release::Conference.select_single({:acronym=>params[:conference]},{:limit=>1,:order=>Momomoto.desc(:conference_release_id)})
      rescue Momomoto::Nothing_found
        @conference = Release_preview::Conference.select_single({:acronym=>params[:conference]})
      end
    end
  end

  protected

  def init
    @current_language = 'en'
    response.content_type = Mime::XML
  end

end
