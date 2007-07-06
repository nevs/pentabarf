class SubmissionController < ApplicationController

  def index
  end

  def person
  end

  def save_person
  end

  protected

  def check_permission
    return POPE.permission?('submission_login')
  end

end
