class Event_person < Momomoto::Table

  def self.log_content_columns
    columns.keys - [:event_person_id]
  end

end

