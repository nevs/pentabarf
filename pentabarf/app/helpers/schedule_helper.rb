module ScheduleHelper

  def sanitize_track( track )
    h( track.to_s.downcase.gsub(/[\W]/, '') )
  end

end
