class FeedController < ApplicationController
  before_filter :authorize
  before_filter :check_permission
  after_filter :compress

  def index
    redirect_to :action => recent_changes
  end

  def recent_changes
    @response.headers['Content-Type'] = "application/xml; charset=utf-8"

    @content_title ='Pentabarf Recent Changes'

    @changes = Momomoto::View_recent_changes.find( {}, 25 )
    @last_modified = 

    # the first element is the most recent one
    @content_updated = @changes.changed_when
  end

  protected

  def check_permission
    false
  end

end
