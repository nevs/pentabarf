module ScheduleHelper

  def sanitize_track( track )
    track = track.to_s.downcase.gsub(/[^a-z0-9]/, '')
    return track == '' ? '' : h("track-#{track}")
  end
            
end
