class AdminController < ApplicationController

  before_filter :init

  def index
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    # FIXME: remove hardcoded language
    @current_language_id = 120
  end

end
