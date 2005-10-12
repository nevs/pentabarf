module FeedHelper
  
  def to_iso8601 (sql_timestamp)
    iso8601_timestamp.sub!(/T/, ' ');
    iso8601_timestamp.sub!(/\.[0-9]*(\+[0-9][0-9])/, '\1:00' );
    return iso8601_timestamp
  end

end
