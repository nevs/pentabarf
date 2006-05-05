class UserController < ApplicationController

  before_filter :authorize, :except => [:forgot_password]
  after_filter :compress

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
