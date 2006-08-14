
require 'yaml'
require 'xmpp4r'
require 'socket'

class JabberLogger

  class << self

    def init
      @@config = {}
      begin
        @@config = YAML.load_file( File.join( RAILS_ROOT, 'config', 'jabber.yml' ) )
      rescue
      end

      return if @@config['recipients'] && @@config['daemon']['socket_path']
      define_method( :log ) do | text | end
    end

    def log( text )
      init if not class_variables.member?(:@@config)
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

