class SubmissionController < ApplicationController
  before_filter :authorize, :except => :index
  after_filter :compress

  def index
    @content_title = 'Submission'
    Momomoto::Base.ui_language_id = 120;
     
  end

  def login

  end

  protected

end
