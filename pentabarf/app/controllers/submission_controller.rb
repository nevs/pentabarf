class SubmissionController < ApplicationController
  before_filter :authorize, :except => [:index, :create_account, :logout]
  before_filter :transparent_authorize
  after_filter :compress

  def index
    @content_title = 'Submission'
    Momomoto::Base.ui_language_id = 120;
  end

  def login
    render_text(@user.inspect)
  end

  def create_account
    @content_title = 'Create account'
    
  end

  def person

  end

  def event
    Notifier::deliver_signup_thanks(@user.login_name, @user.email_contact)

  end

  protected

  def transparent_authorize()
    login_name, password = get_auth_data
    @user = nil

    if !login_name.empty? && !password.empty?
      @user = Momomoto::Login.authorize( login_name, password )
      @user = nil if @user.nil?
    end 
    return true
  end

end
