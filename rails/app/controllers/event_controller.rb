class EventController < ApplicationController

  around_filter :check_current_conference, :except=>[:attachment]
  before_filter :init
  around_filter :update_last_login, :except=>[:copy,:delete,:save]

  def copy
    cp = Copy_event.call({:source_event_id=>params[:event_id],:target_conference_id=>params[:conference_id],:coordinator_id=>POPE.user.person_id})
    redirect_to({:controller=>'event',:action=>'edit',:event_id=>cp[0].copy_event})
  end

  def conflicts
    @event = Event.select_single({:event_id=>params[:event_id]})
    @conflicts = []
    @conflicts += View_conflict_event.call({:conference_id => @event.conference_id},{:event_id=>params[:event_id],:translated=>@current_language})
    @conflicts += View_conflict_event_event.call({:conference_id => @event.conference_id},{:event_id1=>params[:event_id],:translated=>@current_language})
    @conflicts += View_conflict_event_person.call({:conference_id => @event.conference_id},{:event_id=>params[:event_id],:translated=>@current_language})
    @conflicts += View_conflict_event_person_event.call({:conference_id => @event.conference_id},{:event_id1=>params[:event_id],:translated=>@current_language})
    render(:partial=>'conflicts')
  end

  def state
    @content_title = "Events by state: "
    state = Event_state_localized.select_single(:event_state=>params[:event_state],:translated=>POPE.user.current_language)
    @content_title += state.name
    conditions = {:conference_id=>@current_conference.conference_id,:event_state=>params[:event_state],:translated=>POPE.user.current_language}
    conditions[:event_state_progress] = params[:event_state_progress] if params[:event_state_progress]
    @results = View_find_event.select( conditions )
  end

  def own
    @content_title = "Own events"
    @events = {}
    @events[:participant] = View_own_events_participant.select({:person_id=>POPE.user.person_id,:translated=>@current_language,:conference_id=>@current_conference.conference_id},{:order=>[:event_state,:title,:subtitle,:event_role]})
    @events[:coordinator] = View_own_events_coordinator.select({:person_id=>POPE.user.person_id,:translated=>@current_language,:conference_id=>@current_conference.conference_id},{:order=>[:event_state,:title,:subtitle,:event_role]})
  end

  def new
    raise "Not allowed to create event." if not POPE.conference_permission?( 'event::create', @current_conference.conference_id )
    @content_title = "New Event"
    @event = Event.new(:event_id=>0,:conference_id=>@current_conference.conference_id)

    @conference = @current_conference
    @attachments = []
    @event_rating_remark = Event_rating_remark.new
    render(:action=>'edit')
  end

  def edit
    @event = Event.select_single( :event_id => params[:event_id] )
    @content_title = @event.title
    @content_subtitle = @event.subtitle

    @event_rating_remark = Event_rating_remark.select_or_new({:event_id=>@event.event_id,:person_id=>POPE.user.person_id})
    @conference = Conference.select_single( :conference_id => @event.conference_id )
    @current_conference = @conference
    @attachments = View_event_attachment.select({:event_id=>@event.event_id,:translated=>@current_language})
  end

  def save
    event = write_row( Event, params[:event], {:except=>[:event_id,:conference_id],:init=>{:event_id=>nil,:conference_id=>@current_conference.conference_id},:always=>[:public]} )
    custom_bools = Custom_fields.select({:table_name=>:event,:field_type=>:boolean}).map(&:field_name)
    write_row( Custom_event, params[:custom_event], {:preset=>{:event_id=>event.event_id},:always=>custom_bools})
    if params[:event_rating] then
      params[:event_rating].each do | k,v | 
        v[:event_rating_category_id]=k 
        if v[:rating] == "remove"
          v[:rating] == "0"
          v[:remove] = true
        end
      end
      write_rows( Event_rating, params[:event_rating], {:preset=>{:event_id => event.event_id,:person_id=>POPE.user.person_id}})
    end
    params[:event_rating_remark][:remove] = true if params[:event_rating_remark][:remark].to_s.strip == ""
    write_row( Event_rating_remark, params[:event_rating_remark], {:only=>[:remark],:remove=>true,:preset=>{:event_id => event.event_id,:person_id=>POPE.user.person_id}})
    write_rows( Event_person, params[:event_person], {:preset=>{:event_id => event.event_id},:always=>[:event_role_state],:ignore_empty=>:person_id})
    write_rows( Event_link, params[:event_link], {:preset=>{:event_id => event.event_id},:ignore_empty=>:url})
    write_rows( Event_link_internal, params[:event_link_internal], {:preset=>{:event_id => event.event_id},:ignore_empty=>:url})
    write_file_row( Event_image, params[:event_image], {:preset=>{:event_id => event.event_id},:image=>true})
    write_rows( Event_attachment, params[:event_attachment], {:always=>[:public]} )
    write_file_rows( Event_attachment, params[:attachment_upload], {:preset=>{:event_id=>event.event_id}})

    redirect_to( :action => :edit, :event_id => event.event_id )
  end

  def delete
    Event.select_single({:event_id=>params[:event_id]}).delete
    redirect_to(:controller=>'pentabarf',:action=>:index)
  end

  def attachment
    data = View_event_attachment.select_single({:event_attachment_id=>params[:event_attachment_id],:event_id=>params[:event_id],:translated=>@current_language})
    file = data.event_attachment
    response.headers['Content-Disposition'] = "attachment; filename=\"#{file.filename}\""
    response.headers['Content-Type'] = data.mime_type
    response.headers['Content-Length'] = data.filesize
#    response.headers['Last-Modified'] = file.last_modified
    render(:text=>file.data)
   rescue
    render(:text=>"File not found",:status=>404)
  end

  protected

  def init
    if POPE.visible_conference_ids.member?(POPE.user.current_conference_id)
      @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id) rescue Conference.new(:conference_id=>0)
    end
    @current_conference ||= Conference.new(:conference_id=>0)
    
    @current_language = POPE.user.current_language || 'en'
  end

  def check_permission
    case params[:action]
      when 'new' then
        POPE.conference_permission?('pentabarf::login',POPE.user.current_conference_id) &&
        POPE.conference_permission?('event::create',POPE.user.current_conference_id)
      when 'copy' then
        POPE.event_permission?('pentabarf::login',params[:event_id]) &&
        POPE.conference_permission?('event::create',params[:conference_id]) &&
        POPE.event_permission?('event::show',params[:event_id])
      when 'delete' then
        POPE.event_permission?('pentabarf::login',params[:event_id]) &&
        POPE.event_permission?('event::delete',params[:event_id])
      when 'own','state' then
        POPE.conference_permission?('pentabarf::login',POPE.user.current_conference_id) &&
        POPE.conference_permission?('event::show',POPE.user.current_conference_id)
      when 'attachment' then
        (
          POPE.event_permission?('pentabarf::login',params[:event_id]) &&
          POPE.event_permission?('event::show',params[:event_id])
        ) || (
          POPE.event_permission?('submission::login',params[:event_id]) &&
          POPE.event_permission?('event::modify_own',params[:event_id]) &&
          !!Event_attachment.select_single({:event_id=>params[:event_id],:event_attachment_id=>params[:event_attachment_id],:public=>'t'})
        )
      when 'edit','conflicts' then
        POPE.event_permission?('pentabarf::login',params[:event_id]) &&
        POPE.event_permission?('event::show',params[:event_id])
      when 'save' then
        if params[:event_id]
          POPE.event_permission?('pentabarf::login',params[:event_id]) &&
          ( POPE.event_permission?('event::modify',params[:event_id]) ||
            POPE.event_permission?('rating::modify',params[:event_id]) )
        else
          POPE.conference_permission?('pentabarf::login',POPE.user.current_conference_id) &&
          POPE.conference_permission?('event::create',POPE.user.current_conference_id)
        end
      else
        false
    end
  end

end
