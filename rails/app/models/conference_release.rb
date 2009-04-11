class Conference_release < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:conference_release_id]
  end

end

