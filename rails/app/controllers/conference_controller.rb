class ConferenceController < ApplicationController

  around_filter :check_current_conference, :except => [:select,:new,:save,:save_current_conference]
  before_filter :init
  around_filter :update_last_login, :except=>[:copy,:delete,:select]

  def select
    valid_conferences = POPE.conferences_with_permission(:'pentabarf::login')
    case valid_conferences.length
      when 0 then
        # if there is no valid conference immediately redirect to new conference page
        # if the user can login to the backend without an actual conference
        # he has global privileges so a redirect to the new conference page is fine
        redirect_to(:controller=>'conference',:action=>:new)
      when 1 then
        # if there is only one valid conference immediately set it as active conference
        POPE.user.current_conference_id = valid_conferences[0]
        POPE.user.write
        redirect_to(:controller=>'pentabarf')
    end
  end

  def save_current_conference
    POPE.user.current_conference_id = params[:conference_id]
    POPE.user.write
    url = case request.env['HTTP_REFERER']
      when /\/conference\//,/\/event\// then url_for(:controller=>'conference',:action=>:edit,:id=>POPE.user.current_conference_id)
      when nil then url_for(:controller=>'pentabarf',:action=>:index)
      else request.env['HTTP_REFERER']
    end
    redirect_to( url )
  end

  def new
    @content_title = "New Conference"
    @conference = Conference.new(:conference_id=>0)
    @current_conference = @conference
    @conference.feedback_base_url = url_for(:controller=>:pentabarf,:action=>:index,:only_path=>false)

    render(:action=>'edit')
  end

  def edit
    @conference = Conference.select_single( :conference_id => params[:conference_id] )
    @current_conference = @conference
    @content_title = @conference.title
  end

  def save
    conf = write_row( Conference, params[:conference], {:except=>[:conference_id],:always=>[:f_submission_enabled,:f_submission_new_events,:f_submission_writable,:f_visitor_enabled,:f_feedback_enabled,:f_reconfirmation_enabled],:init=>{:conference_id=>nil}} )
    custom_bools = Custom_fields.select({:table_name=>:conference,:field_type=>:boolean}).map(&:field_name)
    write_row( Custom_conference, params[:custom_conference], {:preset=>{:conference_id=>conf.conference_id},:always=>custom_bools})
    write_rows( Conference_link, params[:conference_link], {:preset=>{:conference_id => conf.conference_id},:ignore_empty=>:url})
    write_rows( Conference_day, params[:conference_day], {:preset=>{:conference_id => conf.conference_id},:always=>[:public],:ignore_empty=>:conference_day})
    write_rows( Conference_language, params[:conference_language], {:preset=>{:conference_id => conf.conference_id}})
    write_rows( Conference_team, params[:conference_team], {:preset=>{:conference_id => conf.conference_id},:ignore_empty=>:conference_team})
    write_rows( Conference_track, params[:conference_track], {:preset=>{:conference_id => conf.conference_id},:ignore_empty=>:conference_track})
    write_rows( Conference_release, params[:conference_release], {:preset=>{:conference_id => conf.conference_id},:ignore_empty=>:conference_release})
    write_rows( Conference_room, params[:conference_room], {:preset=>{:conference_id => conf.conference_id},:always=>[:public],:ignore_empty=>:conference_room})
    write_rows( Event_rating_category, params[:event_rating_category], {:preset=>{:conference_id => conf.conference_id},:ignore_empty=>:event_rating_category})
    write_rows( Conference_room_role, params[:conference_room_role] )
    write_file_row( Conference_image, params[:conference_image], {:preset=>{:conference_id => conf.conference_id},:image=>true})

    POPE.user.current_conference_id ||= conf.conference_id
    redirect_to( :action => :edit, :conference_id => conf.conference_id)
  end

  def delete
    Conference.select_single({:conference_id=>params[:conference_id]}).delete
    redirect_to(:controller=>'pentabarf',:action=>:index)
  end

  protected

  def init
    @current_language = POPE.user.current_language
  end

  def check_permission
    # allow select conference if user can at least login into one conference
    if ['select','save_current_conference'].member?(params[:action]) && 
       ( !POPE.conferences_with_permission('pentabarf::login').empty? ||
         POPE.permission?('pentabarf::login') )
      return true 
    end
    return false if not POPE.conference_permission?('pentabarf::login',params[:conference_id])
    case params[:action]
      when 'new' then POPE.permission?('conference::create')
      when 'delete' then POPE.permission?('conference::delete')
      when 'edit' then POPE.conference_permission?('conference::show',params[:conference_id])
      when 'save' then POPE.conference_permission?('conference::modify',params[:conference_id])
      else
        false
    end
  end

end
