class ConferenceController < ApplicationController

  def rename_conference_track
    Conference_track_rename.call({:conference_id=>params[:conference_id],:old_name=>params[:old_name],:new_name=>params[:new_name]})
    render(:text=>"OK")
  end

  def rename_conference_room
    Conference_room_rename.call({:conference_id=>params[:conference_id],:old_name=>params[:old_name],:new_name=>params[:new_name]})
    render(:text=>"OK")
  end

end
