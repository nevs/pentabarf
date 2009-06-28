class SearchController < ApplicationController

  before_filter :init
  around_filter :update_last_login
  around_filter :save_preferences, :only=>[:search_person_simple,:search_person_advanced,:search_event_simple,:search_event_advanced,:search_conference_simple]

  def person
    @content_title = "Search Person"
  end

  def search_person_simple
    query = params[:id] ? @preferences[:search_person_simple].to_s : params[:search_person_simple].to_s
    conditions = {:AND => []}
    query.split(/ +/).each do | word |
      q = "%#{word}%"
      conditions[:AND] << {:OR=>[{:all_names=>{:ilike=>q}},{:email=>{:ilike=>q}}]}
    end
    @results = View_find_person.select( conditions, {:distinct => [:name,:person_id]} )
    @preferences[:search_person_simple] = query
    render(:partial=>'person_results')
  end

  def search_person_advanced
    params[:search_person] = @preferences[:search_person_advanced] if params[:id]
    conditions = form_to_condition( params[:search_person], View_find_person )
    @results = View_find_person.select( conditions, {:distinct=>[:name,:person_id]})
    @preferences[:search_person_advanced] = params[:search_person]
    render(:partial=>'person_results')
  end

  def event
    @content_title = "Search Event"
  end

  def conference
    @content_title = "Search Conference"
  end

  protected

  def init
    if POPE.visible_conference_ids.member?(POPE.user.current_conference_id)
      @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id) rescue Conference.new(:conference_id=>0)
    end
    @current_conference ||= Conference.new(:conference_id=>0)
    
    @current_language = POPE.user.current_language || 'en'
    @preferences = POPE.user.preferences
  end

  def save_preferences
    yield
    POPE.user.preferences = @preferences
  end

  def check_permission
    return false if not POPE.conference_permission?('pentabarf::login',POPE.user.current_conference_id)
    case params[:action]
      when 'person','search_person_simple','search_person_advanced' then
        POPE.conference_permission?('person::show',POPE.user.current_conference_id)
      when 'event' then
        POPE.conference_permission?('event::show',POPE.user.current_conference_id)
      when 'conference' then
        POPE.conference_permission?('conference::show',POPE.user.current_conference_id)
      else
        false
    end
  end

  # converts values submitted by advanced search to a hash understood by momomoto
  def form_to_condition( params, klass )
    conditions = {}
    params.each do | key, value |
      field = value[:key].to_sym
      conditions[field] ||= {}
      value[:type] ||= klass.columns[field].to_s.split('::').last.downcase
      if value[:value] == "" && value[:type] != 'text'
        conditions[field][:eq] ||= []
        conditions[field][:eq] << :NULL
      elsif value[:type] == 'text'
        conditions[field][:ilike] ||= []
        conditions[field][:ilike] << "%#{value[:value]}%"
      else
        conditions[field][:eq] ||= []
        conditions[field][:eq] << value[:value]
      end
    end
    conditions
  end

end
