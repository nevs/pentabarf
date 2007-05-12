
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
   rescue => e
    flush
    raise e
  end

  def deauth
    flush
  end

  def table_write( table, row )
    table_domains( table ) do | domain |
      # if table_name == domain name this is the creation of a new object
      # otherwise it's only a modification
      if table.table_name == domain.to_s && row.new_record?
        raise "Forbidden" if not permissions.member?( "create_#{domain}".to_sym )
      else
        raise "Forbidden" if not permissions.member?( "modify_#{domain}".to_sym )
      end
    end
  end

  def table_delete( table, row )
    table_domains( table ) do | domain |
      # if table_name == domain name this is the deletion of an object
      # otherwise it's only a modification
      if table.table_name == domain.to_s
        raise "Forbidden" if not permissions.member?( "delete_#{domain}".to_sym )
      else
        raise "Forbidden" if not permissions.member?( "modify_#{domain}".to_sym )
      end
    end
  end

  protected

  def table_domains( table )
    domains = []
    [:event,:person,:conference].each do | d |
      if table.columns.key?( "#{d}_id".to_sym )
        domains.push( d )
        yield( d )
      end
    end
    raise "No matching domain" if domains.empty?
  end

  def flush
    @user = nil
    @permissions = []
  end

end

