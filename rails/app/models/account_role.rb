class Account_role < Momomoto::Table
  schema_name "auth"

  def self.log_content_columns
    columns.keys - [:account_id]
  end

  def self.log_change_url( change )
    account = Account.select_single({:account_id=>change.account_id})
    {:controller=>'pentabarf',:action=>:person,:id=>account.person_id}
   rescue
    {}
  end

  def self.log_change_title( change )
    account = Account.select_single({:account_id=>change.account_id})
    begin
      person = Person.select_single({:person_id=>account.person_id})
      person.name
    rescue
      account.login_name
    end
   rescue
    change.account_id
  end

end

