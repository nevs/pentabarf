
# this class handles all authententication and authorization decissions
class Pope

  class PermissionError <  StandardError
  end

  attr_reader :user, :permissions

  def initialize
    @permissions = []
    @domains = {}
    Object_domain.select.each do | row |
      @domains[row.object.to_sym] = row.domain.to_sym
    end
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

    refresh
   rescue => e
    flush
    raise e
  end

  def deauth
    flush
  end

  def refresh
    @permissions = User_permissions.call(:person_id=>@user.person_id).map do | row | row.user_permissions.to_sym end
    if permission?( :modify_own_event )
      @own_events = Own_events.call(:person_id=>@user.person_id).map do | row | row.own_events end
    end
    if permission?( :modify_own_person )
      @own_conference_persons = Own_conference_persons.call(:person_id=>@user.person_id).map do | row | row.own_conference_persons end
    end
  end

  def permission?( perm )
    @permissions.member?( perm.to_sym )
  end

  def table_write( table, row )
    d = domain( table.table_name )
    return if d == :public
    action = row.new_record? ? :create : :modify
    action = :modify if table.table_name.to_sym != d
    return if permission?( "#{action}_#{d}" )
    send( "domain_#{d}", action, row )
   rescue PermissionError
    raise PermissionError, "Not allowed to write #{table.table_name}"
  end

  def table_delete( table, row )
    action = :delete
    d = domain( table.table_name )
    action = :modify if table.table_name.to_sym != d
    return if permission?( "#{action}_#{d}" )
    send( "domain_#{d}", action, row )
   rescue PermissionError
    raise PermissionError, "Not allowed to delete #{table.table_name}"
  end

  def domain_event( action, row )
    if action == :modify && permission?(:modify_own_event)
      return if @own_events.member?( row.event_id )
    end
    raise Pope::PermissionError
  end

  def domain_person( action, row )
    if action == :modify && permission?( :modify_own_person )
      return if row.respond_to?( :person_id ) && row.person_id == @user.person_id
      return if row.respond_to?( :conference_person_id ) && @own_conference_persons.member?( row.conference_person_id )
    end
    raise Pope::PermissionError
  end

  protected

  def domain( object )
    d = @domains[object.to_sym]
    raise "No domain found for #{object}" if not d
    d
  end

  def flush
    @user = nil
    @permissions = []
    @own_events = []
    @own_conference_persons = []
  end

end

