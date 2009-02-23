class Conference_day < Momomoto::Table
  default_order( :conference_day )

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:conference,:id=>change.conference_id}
  end

  def self.log_change_title( change )
    Conference.log_change_title( Conference.select_single(:conference_id=>change.conference_id))
   rescue
    ""
  end

end

