class UserController < ApplicationController

  def index
    @conferences = Conference.select({:f_submission_enabled=>'t'})
  end

  def new_account
  end

  def save_account
    if not params[:person]
      return redirect_to(:action=>:index)
    elsif params[:person][:password] != params[:password]
      raise "Passwords do not match"
    elsif not params[:person][:email_contact].match(/[\w_.+-]+@([\w.+_-]+\.)+\w{2,}$/)
      raise "Invalid email address"
    elsif Person.select({:login_name=>params[:person][:login_name]}).length != 0
      raise "This login name is already in use."
    else
      @conference = Conference.select_single( :acronym => params[:id] ) if params[:id]
      activation_string = random_string
      Notifier::deliver_activate_account( params[:person][:login_name], params[:person][:email_contact], url_for({:action=>:activate_account,:id=>activation_string,:only_path=>false}), @conference && @conference.email )
      account = Create_account.call({:p_login_name=>params[:person][:login_name],:p_password=>params[:person][:password],:p_email_contact=>params[:person][:email_contact],:p_activation_string=>activation_string,:p_conference_id=> @conference.nil? ? 0 : @conference.conference_id })
      redirect_to({:action=>:account_done})
    end
  end

  protected

  def random_string
    sprintf("%064X", rand(2**256))
  end

end
