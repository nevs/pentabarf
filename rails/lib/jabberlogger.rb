
require 'yaml'
require 'socket'

class JabberLogger

  class << self

    def init
      require 'xmpp4r'
      @@config = {}
      begin
        @@config = YAML.load_file( File.join( RAILS_ROOT, 'config', 'jabber.yml' ) )
      rescue
      end

      return true if @@config['recipients'] && @@config['daemon']['socket_path']

     rescue
      # create dummy log method if xmpp4r is missing
      define_method( :log ) do | text | end
      return false
    end

    def log( text )
      return if !class_variables.member?(:@@config) && !init
      @@config['recipients'].each do | recipient |
        msg = Jabber::Message.new(Jabber::JID.new(recipient))
        msg.set_type(:chat)
        msg.set_body( text )
        begin
          sock = UNIXSocket.open(@@config['daemon']['socket_path'])
          sock.send(msg.to_s, 0)
          sock.close
        rescue
          sock.close if sock
          return
        end
      end
    end

  end

end

