class AtomController < ApplicationController

  def recent_changes
    response.content_type = Mime::ATOM
    @current_language = POPE.user.current_language
    @changes = View_recent_changes.select( {}, {:limit => 25 } )
  end

end
