class FeedController < ApplicationController

  def index
    redirect_to :action => recent_changes
  end

  def recent_changes
    @response.headers['Content-Type'] = "application/xml; charset=utf-8"

    @content_lang ='en'
    @content_title ='Pentabarf Recent Changes'
    @content_subtitle ='Last 25 changed objects of the database'

    @content_feed_url = url_for( :controller => "feed", :action => :recent_changes )
    @content_pentabarf_url = url_for( :controller => "pentabarf", :action => :recent_changes )

    @changes = Momomoto::View_recent_changes.find( {}, 25 )

    # the first element is the most recent one
    @content_updated = @changes[0].changed_when
  end

end
