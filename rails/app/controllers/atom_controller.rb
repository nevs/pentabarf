class AtomController < ApplicationController

  def recent_changes
    @changes = View_recent_changes.select( {}, {:limit => 25 } )
  end

end
