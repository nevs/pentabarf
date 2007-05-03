
class Pope

  attr_reader :user, :permissions

  def auth( user, pass )
    @user = Person.select_single(:login_name => user)

    salt = @user.password[0..15]
    salt_bin = ''
    8.times do | count |
      salt_bin += salt[count..(count+1)]
    end
    raise "Wrong Password" unless Digest::MD5.hexdigest( salt_bin + password ) == pass

    @permissions = User_permissions.select(:person_id=>@user.person_id).map do | row | row.user_permissions.to_sym end
   rescue => e
    flush
    raise e
  end

  def deauth
    flush
  end

  def table_write( table, row )
    domains = []
    [:person,:event,:conference].each do | domain |
      if table.columns.key?("#{domain}_id".to_sym)
        domains.push( domain )
        # if table_name == domain name this is the creation of a new object 
        # otherwise it's only a modification
        if table.table_name == domain.to_s && row.new_record?
          raise "Forbidden" if not permissions.member?( "create_#{domain}".to_sym )
        else
          raise "Forbidden" if not permissions.member?( "modify_#{domain}".to_sym )
        end
      end
    end
    raise "No matching domain" if domains.empty?
  end

  def table_delete( table, row )
    raise "Forbidden"
  end

  def flush
    @user = nil
    @permissions = nil
  end

end

