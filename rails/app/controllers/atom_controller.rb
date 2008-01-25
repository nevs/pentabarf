class AtomController < ApplicationController

  def recent_changes
    @current_language = POPE.user.current_language
    @changes = View_recent_changes.select( {}, {:limit => 25 } )
  end

end
