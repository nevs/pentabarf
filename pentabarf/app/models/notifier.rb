class Notifier < ActionMailer::Base

  def signup_thanks( name, email )
    @recipients = email
    @from = "noreply@pentabarf.org"
    @subject = "Thank you for registering at Pentabarf"

    # variables for usage in mail
    @body["name"] = name
    
  end

  def activate_account( name, email, link )
    @recipients = email
    @from = "noreply@pentabarf.org"
    @subject = "Activate your pentabarf account"

    # variables for usage in mail
    @body["name"] = name
    @body["link"] = link
  end

end
