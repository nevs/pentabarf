class UserController < ApplicationController

  def index
    @conferences = Conference.select({:f_submission_enabled=>'t'})
  end

  def new_account
  end

  def save_account
    if not params[:account]
      return redirect_to(:action=>:index)
    elsif params[:account][:password] != params[:password]
      raise "Passwords do not match"
    elsif not params[:account][:email].match(/[\w_.+-]+@([\w.+_-]+\.)+\w{2,}$/)
      raise "Invalid email address"
    elsif Account.select({:login_name=>params[:account][:login_name]}).length != 0
      raise "This login name is already in use."
    else
      @conference = Conference.select_single( :acronym => params[:id] ) if params[:id]
      activation_string = random_string
      Notifier::deliver_activate_account( params[:account][:login_name], params[:account][:email], url_for({:action=>:activate_account,:id=>activation_string,:only_path=>false}), @conference && @conference.email )
      account = Create_account.call({:p_login_name=>params[:account][:login_name],:p_password=>params[:account][:password],:p_email=>params[:account][:email],:p_activation_string=>activation_string,:p_conference_id=> @conference.nil? ? 0 : @conference.conference_id })
      redirect_to({:action=>:account_done})
    end
  end

  def activate_account
    raise "Invalid activation sequence." unless params[:id].to_s.length == 64
    begin
      activation = Activate_account.call({:activation_string=>params[:id]})[0]
      conference = Conference.select_single(:conference_id => activation.activate_account) if activation.activate_account
      redirect_to({:action=>:account_activated,:id => conference.nil? ? nil : conference.acronym })
    rescue => e
      raise e
    end
  end

  def account_activated
    @content_title = "Activation successful"
  end

  def forgot_password
  end

  def save_forgot_password
    begin
      p = Account.select_single( :login_name => params[:login_name], :email => params[:email] )
    rescue
      raise "There is no user with this login name and email address."
    end
    reset = Account_password_reset.select(:account_id=>p.account_id)
    if reset.length == 1 && reset[0].password_reset > DateTime.now - 1
      raise "You have been sent a reset link recently."
    end
    activation_string = random_string
    Notifier::deliver_forgot_password( p.login_name, p.email, url_for({:action=>:reset_password,:id=>activation_string,:only_path=>false}) )
    Forgot_password.call(:p_account_id=>p.account_id,:p_activation_string=>activation_string)
    redirect_to(:action=>:reset_link_sent)
  end

  def reset_password
    return redirect_to(:action=>:forgot_password) if params[:id].to_s.empty?
    Account_password_reset.select_single(:activation_string=>params[:id])
   rescue
    raise "Invalid reset string."
  end

  def save_reset_password
    raise "Passwords do not match" if params[:password] != params[:password2]
    Reset_password.call({:new_password=>params[:password],:reset_string=>params[:id]}) 
    redirect_to(:controller=>'pentabarf',:action=>:index)
  end

  protected

  def auth
    true
  end

  def random_string
    sprintf("%064X", rand(2**256))
  end

end
