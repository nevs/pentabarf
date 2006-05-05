class UserController < ApplicationController

  before_filter :authorize, :except => [:forgot_password]
  after_filter :compress

  def new_account
    @content_title = 'Create account'
  end

  def create_account
    return redirect_to(:action=>:index,:conference=>@conference.acronym) unless params[:person]
    raise "Passwords do not match" if params[:person][:password] != params[:password]
    raise "Invalid email address" unless params[:person][:email_contact].match(/[\w_.+-]+@([\w.+_-]+\.)+\w{2,3}$/)
    raise "This login name is already in use." unless Momomoto::Person.find({:login_name=>params[:person][:login_name]}).nil?
    raise "This email address is already in use." unless Momomoto::Person.find({:email_contact=>params[:person][:email_contact]}).nil?
    Notifier::deliver_activate_account( account.login_name, account.email_contact, url_for({:action=>:activate_account,:conference=>@conference.acronym,:id=>account.activation_string}) )
    account = Momomoto::Create_account.find({:login_name=>params[:person][:login_name],:password=>params[:person][:password],:email_contact=>params[:person][:email_contact],:activation_string=>random_string})

    redirect_to({:action=>:account_done,:conference=>@conference.acronym})
  end

  def account_done

  end

  def activate_account
    raise "Invalid activation sequence." unless params[:id].length == 64
    Momomoto::Activate_account.find({:activation_string=>params[:id]})
    redirect_to({:action=>:login,:conference=>@conference.acronym})
  end

  def forgot_password
    if params[:commit]
      person = Momomoto::Person.find({:login_name=>params[:person][:login_name], :email_contact=>params[:person][:email_contact]})
      raise "This combination of login name and contact email address does not exist!" if person.length != 1
      reset = Momomoto::Account_password_reset.find({:person_id=>person.person_id})
      if reset.length == 0 || reset.password < DateTime.now - 1
        activation_string = random_string
        Notifier::deliver_forgot_password( person.login_name, person.email_contact, url_for({:action=>:reset_password,:conference=>@conference.acronym,:id=>activation_string}) )
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

  end

end
