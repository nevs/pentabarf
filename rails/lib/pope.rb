
# this class handles all authententication and authorization decissions
class Pope

  class PermissionError <  StandardError
  end

  class NoUserData < PermissionError
  end

  class User
    def initialize( account )
      @account = account
      @settings = Account_settings.select_or_new({:account_id=>account.account_id})
    end

    def check_password( pass )
      @account.check_password( pass )
    end

    [:account_id,:login_name,:salt,:password,:edit_token,:person_id].each do | field |
      define_method( field ) do
        @account.send( field )
      end
    end
  
    [:current_conference_id,:current_language,:preferences,:last_login].each do | field |
      define_method( field ) do
        @settings.send( field )
      end

      setter_name = "#{field}="
      define_method( setter_name ) do | value |
        @settings.send( setter_name, value )
      end
    end

    attr_reader :account, :settings

    def write
      @settings.write
    end

  end

  attr_reader :user, :own_events

  def initialize
    flush
    @domains = {}
    Object_domain.select.each do | row |
      @domains[row.object.to_sym] = row.domain.to_sym
    end
  end

  def event_conference( event_id )
    event_id = Integer( event_id )
    if not @event_conference[event_id]
      return nil if not event_id
      begin
        Event.select_single({:event_id=>event_id},{:columns=>[:event_id,:conference_id]})
      rescue Momomoto::Nothing_found
        return nil
      end
    end
    @event_conference[event_id]
  end

  def auth( username, pass )
    deauth
    raise NoUserData if username.to_s.empty? or pass.to_s.empty?
    @user = Pope::User.new( Account.select_single(:login_name => username) )

    if not @user.check_password( pass )
      raise PermissionError, "Wrong Password for User '#{user}'" 
    end

    refresh
    Set_config.call(:setting=>'pentabarf.person_id',:value=>user.person_id,:is_local=>'t')
   rescue => e
    flush
    raise e
  end

  def deauth
    flush
  end

  def refresh
    @permissions = Account_permissions.call(:account_id=>user.account_id).map do | row | row.account_permissions.to_sym end
    @own_events = nil
    @own_conference_persons = nil
  end

  def permission?( perm )
    @permissions.member?( perm.to_sym )
  end

  def visible_conferences
    if !@visible_conferences
      if permission?('conference::show')
        @visible_conferences = Conference.select
      elsif !conferences_with_permission('conference::show').empty?
        @visible_conferences = Conference.select({:conference_id=>conferences_with_permission('conference::show')})
      else
        @visible_conferences = []
      end
    end
    @visible_conferences
  end

  def visible_conference_ids
    @visible_conference_ids ||= visible_conferences.map(&:conference_id)
    @visible_conference_ids
  end

  def conference_permissions
    if !@conference_permissions
      @conference_permissions = {}
      if user 
        Account_conference_permissions.call({:account_id=>user.account_id}).each do | row |
          @conference_permissions[row.conference_id] ||= []
          @conference_permissions[row.conference_id] << row.permission.to_sym
        end
      end
    end
    @conference_permissions
  end

  # returns a list of all conference_ids the account has a certain permission
  def conferences_with_permission( perm )
    conferences = []
    if permission?( perm )
      # return all conferences if user has global permission
      conferences << Conference.select({},{:columns=>[:conference_id]})
    else
      conference_permissions.each do | conference_id, permissions |
        conferences << conference_id if permissions.member?( perm.to_sym )
      end
    end
    conferences
  end

  def conference_permission?( perm, conference_id )
    perm = perm.to_sym
    conf = Integer( conference_id )
    # check for global permission first
    return true if permission?( perm )
    return true if conference_permissions[conf] && conference_permissions[conf].member?( perm.to_sym )
    false
  end

  def event_permission?( perm, event )
    conference_permission?( perm.to_sym, event_conference( event ) )
  end

  # function hooked into momomoto when table rows are written
  def table_select( table, rows )
    # cache conference_ids of events for later usage
    if table.table_name == 'event'
      rows.each do | row | @event_conference[row.event_id] ||= row.conference_id end
    end
    rows
  end

  # function hooked into momomoto when table rows are written
  def table_write( table, row )
    domain = object_domain( table.table_name )
    action = row.new_record? ? :create : :modify
    action = :modify if table.table_name.to_sym != domain
    row_permission( row, domain, action )
   rescue PermissionError
    raise PermissionError, "Not allowed to write #{table.table_name}"
  end

  # function hooked into momomoto when table rows are deleted
  def table_delete( table, row )
    action = :delete
    domain = object_domain( table.table_name )
    action = :modify if table.table_name.to_sym != domain
    row_permission( row, domain, action )
   rescue PermissionError
    raise PermissionError, "Not allowed to delete #{table.table_name}"
  end

  def row_permission( row, domain, action )
    # all action on public domain objects are permitted
    return if domain == :public
    # check for global permissions
    return if permission?( "#{domain}::#{action}" )
    # check for conference permissions
    return if row.respond_to?( :conference_id ) && conference_permission?( "#{domain}::#{action}", row.conference_id )
    return if row.respond_to?( :event_id ) && conference_permission?( "#{domain}::#{action}", event_conference( row.event_id ) )
    # check domain specific handler functions
    return send( "domain_#{domain}", action, row ) if respond_to?( "domain_#{domain}")
    raise PermissionError
  end

  def domain_account( action, row )
    if action == :modify && permission?( :'person::modify_own')
      return if row.respond_to?( :account_id ) && row.account_id == user.account_id
    end
    raise Pope::PermissionError
  end

  def domain_event( action, row )
    if action == :modify && permission?( :'event::modify_own' )
      return if own_event?( row.event_id )
    end
    raise Pope::PermissionError
  end

  def domain_person( action, row )
    if action == :modify && permission?( :'person::modify_own' )
      return if row.respond_to?( :person_id ) && row.person_id == user.person_id
    end
    raise Pope::PermissionError
  end

  def domain_conference_person( action, row )
    if permission?( :'person::modify_own' )
      return if own_conference_person?( row.conference_person_id )
    end
    raise Pope::PermissionError
  end

  def own_event?( event_id )
    if not @own_events
      if user.person_id && permission?( :'event::modify_own' )
        @own_events = Own_events.call(:person_id=>user.person_id).map do | row | row.own_events end
      else
        @own_events = []
      end
    end
    return @own_events.member?( event_id )
  end

  def own_conference_person?( conference_person_id )
    if not @own_conference_persons
      if user.person_id && permission?( :'person::modify_own' )
        @own_conference_persons = Own_conference_persons.call(:person_id=>user.person_id).map do | row | row.own_conference_persons end
      end
    else
      @own_conference_persons = []
    end
    return @own_conference_persons.member?( conference_person_id )
  end

  protected

  def object_domain( object )
    domain = @domains[object.to_sym]
    raise "No domain found for #{object}" if not domain
    domain
  end

  def flush
    @user = nil
    @permissions = []
    @visible_conferences = nil
    @visible_conference_ids = nil
    @conference_permissions = nil
    @own_events = nil
    @own_conference_persons = nil
    @event_conference = {}
    Set_config.call(:setting=>'pentabarf.person_id',:value=>'',:is_local=>'f')
  end

end

