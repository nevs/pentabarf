class Notifier < ActionMailer::Base

  @@config = YAML.load_file( File.join( RAILS_ROOT, 'config', 'mail.yml' ) ) if File.exists?( File.join( RAILS_ROOT, 'config', 'mail.yml' ) )
  @@config[:from] = 'noreply@pentabarf.org' unless @@config[:from]

  def signup_thanks( name, email )
    @recipients = email
    @subject = "Thank you for registering at Pentabarf"
    @from = @@config[:from]

    # variables for usage in mail
    @body["name"] = name
  end

  def activate_account( name, email, link )
    @recipients = email
    @subject = "Activate your pentabarf account"
    @from = @@config[:from]

    # variables for usage in mail
    @body["name"] = name
    @body["link"] = link
  end

end
