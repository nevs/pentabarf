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

  def activate_account
    raise "Invalid activation sequence." unless params[:id].length == 64
    begin
      activation = Activate_account.call({:activation_string=>params[:id]})[0]
      @conference = Conference.select_single(:conference_id => activation.activate_account) if activation.activate_account
      redirect_to({:controller=>'submission',:conference=> @conference.nil? ? nil : @conference.acronym })
    rescue => e
      raise e
    end
  end

  def forgot_password
  end

  def save_forgot_password
  end

  protected

  def auth
#    return super unless ['index','new_account','save_account','activate_account'].member?( params[:action] )
    true
  end

  def random_string
    sprintf("%064X", rand(2**256))
  end

end
