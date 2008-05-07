class Conference_person < Momomoto::Table

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:person,:id=>change.person_id}
  end

end

