class ConferenceController < ApplicationController

  before_filter :init
  before_filter :check_transaction, :only => :save

  def new
    raise "Not allowed to create conference." if not POPE.permission?( 'conference::create' )
    @content_title = "New Conference"
    @conference = Conference.new(:conference_id=>0)
    @conference.feedback_base_url = url_for(:controller=>:pentabarf,:action=>:index,:only_path=>false)

    @transaction = Conference_transaction.new({:conference_id=>@conference.conference_id})
    render(:action=>'edit')
  end

  def edit
    @conference = Conference.select_single( :conference_id => params[:conference_id] )
    @content_title = @conference.title
    @current_conference = @conference
    @transaction = Conference_transaction.select_or_new({:conference_id=>@conference.conference_id},{:limit=>1})
  end

  def save
    if params[:transaction].to_i != 0
      transaction = Conference_transaction.select_single({:conference_id=>params[:conference_id]},{:limit=>1})
      if transaction.conference_transaction_id != params[:transaction].to_i
        raise "Simultanious edit"
      end
    end

    params[:conference][:conference_id] = nil if params[:id].to_i == 0
    conf = write_row( Conference, params[:conference], {:except=>[:conference_id],:always=>[:f_submission_enabled,:f_submission_new_events,:f_submission_writable,:f_visitor_enabled,:f_feedback_enabled,:f_reconfirmation_enabled]} )
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
    Conference_transaction.new({:conference_id=>conf.conference_id,:changed_by=>POPE.user.person_id}).write

    redirect_to( :action => :conference, :id => conf.conference_id)
  end

  protected

  def init
    @current_language = POPE.user.current_language
  end

  def check_permission
    return POPE.conference_permission?('pentabarf::login',params[:conference_id])
  end

end
