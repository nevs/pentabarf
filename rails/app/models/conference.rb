class Conference < Momomoto::Table
  default_order( Momomoto.lower(:acronym) )

  def self.log_content_columns
    columns.keys - [:conference_id]
  end

  def self.log_hidden_columns
    [:css]
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:conference,:id=>change.conference_id}
  end

  def self.log_change_title( change )
    change.title
  end

end
