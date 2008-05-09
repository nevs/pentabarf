class Event_rating < Momomoto::Table

  def log_content_columns
    columns.keys - [:eval_time]
  end

end

