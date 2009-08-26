require 'digest/md5'

class Account < Momomoto::Table
  schema_name "auth"
  module Methods

    def password=( value )
      srand()
      salt = []
      8.times do salt << rand(256) end

      salt_bin = salt.pack("C8")
      salt_hex = salt_bin.unpack("H16")[0]

      hash = Digest::MD5.hexdigest( salt_bin + value.to_s )
      set_column( :salt, salt_hex )
      set_column( :password, hash )
    end

    def check_password( pass )
      salt = get_column( :salt )
      salt_bin = [salt.to_i( 16 )].pack("Q").reverse

      if Digest::MD5.hexdigest( salt_bin + pass ) == get_column( :password )
        return true
      else
        return false
      end
    end

  end

  def self.log_content_columns
    columns.keys - [:account_id,:salt]
  end

  def self.log_hidden_columns
    [:password]
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:person,:id=>change.person_id}
  end

  def self.log_change_title( change )
    Person.log_change_title( Person.select_single({:person_id=>change.person_id}))
   rescue
    change.login_name
  end

end

