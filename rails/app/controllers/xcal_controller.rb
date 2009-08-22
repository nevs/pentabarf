class XcalController < ApplicationController

  before_filter :init
  after_filter :content_type

  def conference
    begin
      @conference = Release::Conference.select_single({:conference_id=>params[:conference_id]},{:limit=>1,:order=>Momomoto.desc(:conference_release_id)})
    rescue Momomoto::Nothing_found
      @conference = Release_preview::Conference.select_single({:conference_id=>params[:conference_id]})
    end
    @filename = "#{@conference.acronym}.xcs"
  end

  protected

  def init
    @current_language = 'en'
  end

  def check_permission
    return false if not POPE.conference_permission?('pentabarf::login',params[:conference_id])
    case params[:action]
      when 'conference' then POPE.conference_permission?('conference::show',params[:conference_id])
      else
        false
    end
  end

  def content_type
    if @filename
      response.headers['Content-Type'] = 'application/calendar+xml'
      response.headers['Content-Disposition'] = "attachment; filename=\"#{@filename}\""
    end
  end

end
