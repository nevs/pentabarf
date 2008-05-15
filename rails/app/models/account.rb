require 'digest/md5'
class Account < Momomoto::Table
  schema_name "auth"
  module Methods

    def password=( value )
      srand()
      salt = []
      8.times do salt << rand(256) end

      salt_bin, salt_hex = '', ''
      for number in salt
        salt_bin += sprintf('%c', number)
        salt_hex += sprintf('%02x', number)
      end

      hash = Digest::MD5.hexdigest( salt_bin + value.to_s )
      set_column( :salt, salt_hex )
      set_column( :password, hash )
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

