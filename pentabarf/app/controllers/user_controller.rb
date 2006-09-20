class UserController < ApplicationController

  before_filter :authorize, :except => [:index, :account_done, :activate_account, :create_account, :forgot_password, :new_account, :reset_link_sent, :reset_password]
  before_filter :transparent_authorize
  after_filter :compress

  def index
    @conferences = Momomoto::Conference.find({:f_submission_enabled=>'t'},nil,"lower(title)")
  end
  
  def preferences
  end

  def save_preferences
    raise "Passwords do not match" if params[:person][:password] != params[:password]
    person = Momomoto::Person.find({:person_id=>@user.person_id})
    person.password = params[:person][:password] if params[:person][:password].to_s.length > 0
    preferences = person.preferences
    preferences[:current_language_id] = params[:person][:preferences][:current_language_id].to_i
    preferences[:hits_per_page] = params[:person][:preferences][:hits_per_page].to_i
    person.preferences = preferences
    person.write

    redirect_to({:action=>:preferences})
  end

  def new_account
    @content_title = 'Create account'
  end

  def create_account
    if not params[:person]
      return redirect_to(:action=>:index) 
    elsif params[:person][:password] != params[:password]
      raise "Passwords do not match" 
    elsif not params[:person][:email_contact].match(/[\w_.+-]+@([\w.+_-]+\.)+\w{2,}$/)
      raise "Invalid email address" 
    elsif not Momomoto::Person.find({:login_name=>params[:person][:login_name]}).nil?
      raise "This login name is already in use." 
    elsif Momomoto::Person.find({:email_contact=>params[:person][:email_contact], :login_name => true }).length > 0
      raise "This email address is already in use."
    else
      activation_string = random_string
      Notifier::deliver_activate_account( params[:person][:login_name], params[:person][:email_contact], url_for({:action=>:activate_account,:id=>activation_string,:only_path=>false}) )
      account = Momomoto::Create_account.find({:login_name=>params[:person][:login_name],:password=>params[:person][:password],:email_contact=>params[:person][:email_contact],:activation_string=>activation_string})
      redirect_to({:action=>:account_done})
    end
  end

  def account_done
  end

  def activate_account
    raise "Invalid activation sequence." unless params[:id].length == 64
    begin
      Momomoto::Activate_account.find({:activation_string=>params[:id]})
    rescue => e
      Momomoto::Activate_account.new.rollback
      raise e
    end
    redirect_to({:action=>:preferences})
  end

  def forgot_password
    if params[:commit]
      person = Momomoto::Person.find({:login_name=>params[:person][:login_name], :email_contact=>params[:person][:email_contact]})
      if person.length != 1
        raise "This combination of login name and contact email address does not exist!" 
      elsif Momomoto::Person_role.find({:person_id=>person.person_id}).length == 0
        raise "Account has to be reenabled by an administrator."
      end
      reset = Momomoto::Activation_string_reset_password.find({:person_id=>person.person_id})
      if reset.length == 0 || reset.password_reset < DateTime.now - 1
        activation_string = random_string
        Notifier::deliver_forgot_password( person.login_name, person.email_contact, url_for({:action=>:reset_password,:id=>activation_string,:only_path=>false}) )
        account = Momomoto::Account_forgot_password.find({:person_id=>person.person_id,:activation_string=>activation_string})
        return redirect_to({:action=>:reset_link_sent})
      else
        raise "An activation link has already been sent to you recently."
      end
    end
  end

  def reset_link_sent
  end

  def reset_password
    if params[:commit] && params[:id]
      activation_string = Momomoto::Activation_string_reset_password.new
      if activation_string.select({:activation_string=>params[:id]}) == 1
        raise "Passwords do not match." if params[:person][:password] != params[:password]
        Momomoto::Account_reset_password.select({:activation_string=>params[:id],:login_name=>params[:person][:login_name], :password=>params[:person][:password]})
        redirect_to(:action=>:index)
      else
        raise "Invalid activation sequence."
      end
    end
  end

  protected

  def random_string
    sprintf("%064X", rand(2**256))
  end

end
