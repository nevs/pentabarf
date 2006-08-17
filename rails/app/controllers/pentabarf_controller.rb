class PentabarfController < ApplicationController
  after_filter :compress
  session(:off)

  def index
    @conference = Conference.select_or_new(:conference_id => 1)
  end

end
