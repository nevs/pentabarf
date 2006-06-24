class Notifier < ActionMailer::Base

  if File.exists?( File.join( RAILS_ROOT, 'config', 'mail.yml' ) )
    @@config = YAML.load_file( File.join( RAILS_ROOT, 'config', 'mail.yml' ) )
    @@config.each do | key, value | @@config[key.to_sym] = value end
  else
    @@config = {}
  end
  @@config[:from] = 'noreply@pentabarf.org' unless @@config[:from]

  def general( recipients, subject, body )
    @recipients = recipients
    @subject = subject
    @from = @@config[:from]
    @body['text'] = body
  end

  def activate_account( name, email, link )
    @recipients = email
    @subject = "Activate your pentabarf account"
    @from = @@config[:from]

    # variables for usage in mail
    @body["name"] = name
    @body["link"] = link
  end

  def forgot_password( name, email, link )
    @recipients = email
    @subject = "Pentabarf password reset"
    @from = @@config[:from]

    # variables for usage in mail
    @body["name"] = name
    @body["link"] = link
  end

end
