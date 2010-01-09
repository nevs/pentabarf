
class MailLogger

  class << self

    def init
      @@config = YAML.load_file( File.join( RAILS_ROOT, 'config', 'mail.yml' ) )

      raise 'Mail not configured' if !( @@config['from'] && @@config['exception_recipients'] )

      return true
     rescue Exception
      return false
    end

    def log( subject, text )
      return if !class_variables.member?(:@@config) && !init

      subject = @@config['exception_subject'].to_s + ': ' + subject

      @@config['exception_recipients'].each do | recipient |
        Notifier::deliver_general(recipient, subject, text, @@config['from'])
      end

    end

  end

end

