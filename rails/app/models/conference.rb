class Conference < Momomoto::Table
  default_order( Momomoto.lower(:acronym) )

  def self.log_content_columns
    columns.keys - [:conference_id]
  end

  def self.log_hidden_columns
    [:css]
  end

end
