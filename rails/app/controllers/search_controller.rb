class SearchController < ApplicationController

  before_filter :init
  around_filter :update_last_login
  around_filter :save_preferences, :except=>[:person,:event,:conference,:account]

  def account
    @content_title = "Search Account"
  end

  def search_account
    query = params[:id] ? @preferences[:search_account].to_s : params[:search_account].to_s
    conditions = {:AND => []}
    query.split(/ +/).each do | word |
      constraint = []
      [:login_name,:account_email,:first_name,:last_name,:public_name,:nickname,:person_email,:name].each do | field |
        constraint << {field=>{:ilike=>"%#{word}%"}}
      end
      conditions[:AND] << {:OR=>constraint}
    end
    @results = View_find_account.select( conditions )
    @preferences[:search_account] = query
    render(:partial=>'account_results')
  end

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

  def search_event_simple
    conditions = {:AND=>[]}
    conditions[:conference_id] = @current_conference.conference_id
    conditions[:translated] = @current_language
    query = params[:id] ? @preferences[:search_event_simple].to_s : params[:search_event_simple].to_s
    query.split(/ +/).each do | word |
      q = "%#{word}%"
      conditions[:AND] << {:OR=>[{:title=>{:ilike=>q}},{:subtitle=>{:ilike=>q}}]}
    end
    @results = View_find_event.select( conditions )
    @preferences[:search_event_simple] = query
    render(:partial=>'event_results')
  end

  def search_event_advanced
    params[:search_event] = @preferences[:search_event_advanced] if params[:id]
    conditions = form_to_condition( params[:search_event], View_find_event )
    conditions[:conference_id] = @current_conference.conference_id
    conditions[:translated] = @current_language
    conditions[:AND] = []
    conditions[:AND] << {:OR=>[{:title=>conditions[:title]},{:subtitle=>conditions[:title]}]} if conditions[:title]
    conditions[:AND] << {:OR=>[{:abstract=>conditions[:description]},{:description=>conditions[:description]}]} if conditions[:description]
    conditions.delete(:title)
    conditions.delete(:description)
    @results = View_find_event.select( conditions )
    @preferences[:search_event_advanced] = params[:search_event]
    render(:partial=>'event_results')
  end

  def conference
    @content_title = "Search Conference"
  end

  def search_conference_simple
    conditions = {}
    query = params[:id] ? @preferences[:search_conference_simple].to_s : params[:search_conference_simple].to_s
    if not query.empty?
      conditions[:AND] = []
      query.split(/ +/).each do | word |
        cond = {}
        [:acronym,:title,:subtitle].each do | field |
          cond[field] = {:ilike=>"%#{word}%"}
        end
        conditions[:AND] << {:OR=>cond}
      end
    end
    @results = View_find_conference.select( conditions )
    @preferences[:search_conference_simple] = query
    render(:partial=>'conference_results')
  end

  def search_sidebar
    conditions = {:person=>{:AND=>[]},:event=>{:AND=>[]},:conference=>{:AND=>[]}}
    conditions[:event].merge({:conference_id=>@current_conference.conference_id,:translated=>@current_language})
    fields = {
      :event=>[:title,:subtitle,:slug],
      :person=>[:all_names,:email],
      :conference=>[:title,:subtitle,:acronym]
    }
    params[:sidebar_search].split(/ +/).each do | word |
      fields.each do | table, table_fields |
        find = {}
        table_fields.each do | field | find[field] = {:ilike=>"%#{word}%"} end
        conditions[table][:AND] << {:OR=>find}
      end
    end
    @persons = View_find_person.select( conditions[:person], {:distinct=>[:name,:person_id]})
    @events = View_find_event.select( conditions[:event], {:distinct=>[:title,:subtitle,:event_id]})
    @conferences = View_find_conference.select( conditions[:conference] )
    render(:partial=>'sidebar_results')
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
      when 'event','search_event_simple','search_event_advanced' then
        POPE.conference_permission?('event::show',POPE.user.current_conference_id)
      when 'conference','search_conference_simple' then
        POPE.conference_permission?('conference::show',POPE.user.current_conference_id)
      when 'account','search_account'
        POPE.permission?('account::show')
      when 'search_sidebar'
        # FIXME implement permission checking in search_sidebar
        true
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
