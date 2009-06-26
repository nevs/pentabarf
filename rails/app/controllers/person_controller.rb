class PersonController < ApplicationController

  before_filter :init
  around_filter :update_last_login, :except=>[:copy,:delete,:save]

  def conflicts
    @conflicts = []
    @conflicts += View_conflict_person.call({:conference_id => @current_conference.conference_id},{:person_id=>params[:person_id],:translated=>@current_language})
    @conflicts += View_conflict_event_person.call({:conference_id => @current_conference.conference_id},{:person_id=>params[:person_id],:translated=>@current_language})
    @conflicts += View_conflict_event_person_event.call({:conference_id => @current_conference.conference_id},{:person_id=>params[:person_id],:translated=>@current_language})
    @conflicts.length > 0 ? render( :partial => 'conflicts' ) : render( :text => '' )
  end

  def new
    @content_title = "New Person"
    @person = Person.new(:person_id=>0)
    @person_image = Person_image.new({:person_id=>@person.person_id})
    @person_rating = Person_rating.new({:person_id=>@person.person_id,:evaluator_id=>POPE.user.person_id})

    @conference = @current_conference
    @conference_person = Conference_person.new({:conference_id=>@conference.conference_id, :person_id=>@person.person_id})
    @conference_person_travel = Conference_person_travel.new({:conference_person_id=>@conference_person.conference_person_id.to_i})
    @account = Account.new(:person_id=>@person.person_id)
    @account_roles = []
    @account_conference_roles = []
    @settings = Account_settings.new(:account_id=>@account.account_id.to_i)
    @transaction = Person_transaction.new({:person_id=>@person.person_id})
    render(:action=>'edit')
  end

  def edit
    @person = Person.select_single( :person_id => params[:person_id] )
    @content_title = @person.name
    @conference = @current_conference
    @conference_person = Conference_person.select_or_new({:conference_id=>@conference.conference_id, :person_id=>@person.person_id})
    @conference_person_travel = Conference_person_travel.select_or_new({:conference_person_id=>@conference_person.conference_person_id.to_i})
    @person_rating = Person_rating.select_or_new({:person_id=>@person.person_id,:evaluator_id=>POPE.user.person_id})
    @person_image = Person_image.select_or_new({:person_id=>@person.person_id})
    @account = Account.select_or_new(:person_id=>@person.person_id)
    @settings = Account_settings.select_or_new(:account_id=>@account.account_id.to_i)
    @account_roles = @account.new_record? ? [] : Account_role.select(:account_id=>@account.account_id)
    @account_conference_roles = @account.new_record? ? [] : Account_conference_role.select(:account_id=>@account.account_id,:conference_id=>@conference.conference_id)
    @transaction = Person_transaction.select_or_new({:person_id=>@person.person_id},{:limit=>1})
  end

  def save
    if params[:transaction].to_i != 0
      transaction = Person_transaction.select_single({:person_id=>params[:person_id]},{:limit=>1})
      if transaction.person_transaction_id != params[:transaction].to_i
        raise "Simultanious edit"
      end
    end

    params[:person][:person_id] = params[:person_id] if params[:person_id].to_i > 0
    person = write_row( Person, params[:person], {:except=>[:person_id],:always=>[:spam]} )
    if params[:account]
      params[:account][:account_id] = Account.select_single(:person_id=>person.person_id).account_id rescue nil
      account = write_row( Account, params[:account], {:except=>[:account_id,:salt,:edit_token,:password,:password2],:preset=>{:person_id=>person.person_id},:ignore_empty=>:login_name} ) do | row |
        if params[:account][:password].to_s != "" && ( row.account_id == POPE.user.account_id || POPE.permission?( 'account::modify' ) )
          raise "Passwords do not match" if params[:account][:password] != params[:account][:password2]
          row.password = params[:account][:password]
        end
      end
      write_row( Account_settings, params[:account_settings], {:preset=>{:account_id=>account.account_id}}) unless account.new_record?
    end
    conference_person = write_row( Conference_person, params[:conference_person], {:always=>[:arrived,:reconfirmed],:preset=>{:person_id => person.person_id,:conference_id=>@current_conference.conference_id}})
    POPE.refresh
    custom_bools = Custom_fields.select({:table_name=>:person,:field_type=>:boolean}).map(&:field_name)
    write_row( Custom_person, params[:custom_person], {:preset=>{:person_id=>person.person_id},:always=>custom_bools})
    custom_bools = Custom_fields.select({:table_name=>:conference_person,:field_type=>:boolean}).map(&:field_name)
    write_row( Custom_conference_person, params[:custom_conference_person], {:preset=>{:person_id=>person.person_id,:conference_id=>conference_person.conference_id},:always=>custom_bools})
    write_row( Conference_person_travel, params[:conference_person_travel], {:preset=>{:conference_person_id => conference_person.conference_person_id},:always=>[:need_travel_cost,:need_accommodation,:need_accommodation_cost,:arrival_pickup,:departure_pickup]})
    write_row( Person_rating, params[:person_rating], {:preset=>{:person_id => person.person_id,:evaluator_id=>POPE.user.person_id}})
    write_rows( Person_language, params[:person_language], {:preset=>{:person_id => person.person_id}})
    write_rows( Conference_person_link, params[:conference_person_link], {:preset=>{:conference_person_id => conference_person.conference_person_id},:ignore_empty=>:url})
    write_rows( Conference_person_link_internal, params[:conference_person_link_internal], {:preset=>{:conference_person_id => conference_person.conference_person_id},:ignore_empty=>:url})
    write_rows( Person_im, params[:person_im], {:preset=>{:person_id => person.person_id},:ignore_empty=>:im_address})
    write_rows( Person_phone, params[:person_phone], {:preset=>{:person_id => person.person_id},:ignore_empty=>:phone_number})
    write_rows( Event_person, params[:event_person], {:preset=>{:person_id => person.person_id}})

    write_file_row( Person_image, params[:person_image], {:preset=>{:person_id => person.person_id},:always=>[:public],:image=>true})
    write_person_availability( @current_conference, person, params[:person_availability])

    if POPE.permission?( 'account::modify' )
      params[:account_role].each do | k,v | v[:remove] = true if not v[:set] end
      write_rows( Account_role, params[:account_role], {:preset=>{:account_id=>account.account_id},:except=>[:set]})

      params[:account_conference_role].each do | k,v | v[:remove] = true if not v[:set] end
      write_rows( Account_conference_role, params[:account_conference_role], {:preset=>{:account_id=>account.account_id,:conference_id=>@current_conference.conference_id},:except=>[:set]})
    end
    Person_transaction.new({:person_id=>person.person_id,:changed_by=>POPE.user.person_id}).write

    redirect_to( :action => :edit, :person_id => person.person_id )
  end

  def delete
    Person.select_single({:person_id=>params[:person_id]}).delete
    redirect_to(:controller=>'pentabarf',:action=>:index)
  end

  protected

  def init
    if POPE.visible_conference_ids.member?(POPE.user.current_conference_id)
      @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id) rescue Conference.new(:conference_id=>0)
    end
    @current_conference ||= Conference.new(:conference_id=>0)
    
    @preferences = POPE.user.preferences
    @current_language = POPE.user.current_language || 'en'
  end


  def check_permission
    return false if not POPE.conference_permission?('pentabarf::login',POPE.user.current_conference_id)
    case params[:action]
      when 'new' then POPE.conference_permission?('person::create',POPE.user.current_conference_id)
      when 'delete' then POPE.permission?('person::delete')
      when 'edit','conflicts' then POPE.conference_permission?('person::show',POPE.user.current_conference_id)
      when 'save' then POPE.conference_permission?('person::modify',POPE.user.current_conference_id)
      else
        false
    end
  end

end
