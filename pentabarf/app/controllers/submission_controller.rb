class SubmissionController < ApplicationController
  before_filter :authorize
  after_filter :compress

  def index
     
  end

  protected

end
