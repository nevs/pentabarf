class Person < Momomoto::Table
  module Methods

    def name
      if public_name
        public_name
      elsif first_name && last_name
        "#{first_name} #{last_name}"
      elsif last_name
        last_name
      else
        nickname
      end
    end

  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:person,:id=>change.person_id}
  end

  def self.log_change_title( change )
    change.name
  end

end

