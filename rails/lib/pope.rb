
# this class handles all authententication and authorization decissions
class Pope

  attr_reader :user, :permissions

  def initialize
    @permissions = []
  end

  def auth( user, pass )
    deauth
    @user = Person.select_single(:login_name => user)

    salt = @user.password[0..15]
    salt_bin = ''
    8.times do | count |
      count *= 2
      salt_bin += sprintf( "%c", salt[count..(count+1)].hex )
    end
    raise "Wrong Password" if Digest::MD5.hexdigest( salt_bin + pass ) != @user.password[16..47]

    @permissions = User_permissions.call(:person_id=>@user.person_id).map do | row | row.user_permissions.to_sym end
    @own_events, @own_conference_persons = [], []
    if permission?( :modify_own_event )
      @own_events = Own_events.call(:person_id=>@user.person_id).map do | row | row.own_events end
    end
    if permission?( :modify_own_person )
      @own_conference_persons = Own_conference_persons.call(:person_id=>@user.person_id).map do | row | row.own_conference_persons end
    end
   rescue => e
    flush
    raise e
  end

  def deauth
    flush
  end

  def permission?( perm )
    @permissions.member?( perm.to_sym )
  end

  def table_write( table, row )
    table_domains( table ).each do | domain |
      action = 'modify' if table.table_name != table.table_name
      if action == 'modify'
        case domain
          when :event then return true if @own_events.member?( row.event_id )
          when :person then return true if permission?( :modify_own_person ) && row.person_id == @user.person_id
          when :conference_person then return true if @own_conference_persons.member?( row.conference_person_id )
        end
      end
      domain = :person if domain == :conference_person
      return true if permissions.member?( "#{action}_#{domain}".to_sym )
    end
  end

  def table_delete( table, row )
    table_domains( table ).each do | domain |
      action = 'modify' if table.table_name != table.table_name
      domain = :person if domain == :conference_person
      return true if permissions.member?( "#{action}_#{domain}".to_sym )
    end
  end

  protected

  def table_domains( table )
    domains = []
    [:event,:person,:conference,:conference_person].each do | d |
      if table.columns.key?( "#{d}_id".to_sym )
        domains.push( d )
      end
    end
    if table.table_name.match( /_localized$/ ) && table.columns.key?(:language_id)
      domains.push( :localization )
    end
    if ['conference_phase_conflict'].member?( table.table_name )
      domains.push( :config )
    end
    raise "No domain found for table #{table}" if domains.empty?
    domains
  end

  def flush
    @user = nil
    @permissions = []
  end

end

