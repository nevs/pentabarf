class Notifier < ActionMailer::Base

  if File.exists?( File.join( RAILS_ROOT, 'config', 'mail.yml' ) )
    @@config = YAML.load_file( File.join( RAILS_ROOT, 'config', 'mail.yml' ) )
    @@config.each do | key, value | @@config[key.to_sym] = value end
  else
    @@config = {}
  end
  @@config[:from] = 'noreply@pentabarf.org' unless @@config[:from]

  def general( recipients, subject, body, from = nil )
    @recipients = recipients
    @subject = subject
    @from = from || @@config[:from]
    @body['text'] = body
    @cc = @@config[:always_cc]
  end

  def activate_account( name, email, link, from = nil )
    @recipients = email
    @subject = "Activate your pentabarf account"
    @from = from || @@config[:from]

    # variables for usage in mail
    @body["name"] = name
    @body["link"] = link
  end

  def forgot_password( name, email, link, from = nil )
    @recipients = email
    @subject = "Pentabarf password reset"
    @from = from || @@config[:from]

    # variables for usage in mail
    @body["name"] = name
    @body["link"] = link
  end

end
