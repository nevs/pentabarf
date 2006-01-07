# The filters added to this controller will be run for all controllers in the application.
# Likewise will all the methods added be available for all controllers.

require 'zlib'
require 'stringio'
require 'socket'
require 'xmpp4r'

class ApplicationController < ActionController::Base
  session :off

  def get_auth_data 
    login_name, password = '', '' 
    # extract authorisation credentials 
    if request.env.has_key? 'X-HTTP_AUTHORIZATION' 
      # try to get it where mod_rewrite might have put it 
      authdata = @request.env['X-HTTP_AUTHORIZATION'].to_s.split 
    elsif request.env.has_key? 'HTTP_AUTHORIZATION' 
      # try to get it where fastcgi has put it
      authdata = @request.env['HTTP_AUTHORIZATION'].to_s.split  
    elsif request.env.has_key? 'Authorization' 
      # this is the regular location 
      authdata = @request.env['Authorization'].to_s.split  
    end 
     
    # at the moment we only support basic authentication 
    if authdata and authdata[0] == 'Basic' 
      login_name, password = Base64.decode64(authdata[1]).split(':')[0..1] 
    end 
    return [login_name.to_s, password.to_s] 
  end 

  def authorize( realm='Pentabarf', errormessage='Authentication failed')
    login_name, password = get_auth_data
    @user = Momomoto::Login.new

    if @user.authorize( login_name, password )
      # user exists and password is correct ... horray! 
      return true
    else 
      # the user does not exist or the password was wrong 
      @response.headers["Status"] = "Unauthorized" 
      @response.headers["WWW-Authenticate"] = "Basic realm=\"#{realm}\"" 
      ApplicationController.jabber_message( "Authorization failed for user #{login_name} from #{@request.env['REMOTE_ADDR']}" ) if login_name.to_s.length > 0
      render_text(errormessage, 401)       
    end 
    return false
  end

  def logout( realm='Pentabarf', errormessage='Logged out.')
    @response.headers["Status"] = "Unauthorized" 
    @response.headers["WWW-Authenticate"] = "Basic realm=\"#{realm}\"" 
    render_text(errormessage , 401)       
  end

  def compress 
    accepts = request.env['HTTP_ACCEPT_ENCODING'] 
    return unless accepts && accepts =~ /(x-gzip|gzip)/ 
    encoding = $1 
    output = StringIO.new 
    def output.close # Zlib does a close. Bad Zlib... 
      rewind 
    end 
    gz = Zlib::GzipWriter.new(output) 
    gz.write(response.body) 
    gz.close 
    if output.length < response.body.to_s.length 
      response.body = output.string 
      response.headers['Content-encoding'] = encoding 
    end 
  end 

  def fold 
    max_octets = 70
    folded_body = ""
    response.body.each_line do | line |
      while line.length > max_octets do
        folded_body += line[0..(max_octets - 1)]
        folded_body += "\r\n "
        line = line[max_octets..line.length]
      end
      folded_body += line
    end
    response.body = folded_body
  end 

  def rescue_action_in_public( exception )
    @meditation_message = exception.message
    render :file => '../app/views/meditation.rhtml'
  end

  def log_error( exception )
    super( exception )

    message = ''
    message += "User: #{@user.login_name}\n" if @user
    message += "Time: #{Time.now.to_s}\n"
    message += "UA: #{@request.env['HTTP_USER_AGENT']}\n"
    message += "IP: #{@request.remote_ip}\n"
    message += "URL: https://#{@request.host + @request.request_uri}\n"
    message += "Exception: #{exception.to_s}\n"
    message += "Exception Class: #{exception.class}\n"
    message += "Backtrace:\n"
    message += clean_backtrace(exception).join("\n")
    message += "\n"
    message += "Request: #{params.inspect}\n"

    begin
      ApplicationController.jabber_message( message )
    rescue => e
      logger.error(e)
    end
  end

  def self.jabber_message( text )
    begin
      config = YAML.load_file( '../config/jabber.yml' )
    rescue
      return
    end

    if config['recipients'] && config['daemon']['socket_path']
      config['recipients'].each do | recipient |
        msg = Jabber::Message.new(Jabber::JID.new(recipient))
        msg.set_type(:chat)
        msg.set_body( text )
        begin
          sock = UNIXSocket.open(config['daemon']['socket_path'])
          sock.send(msg.to_s, 0)
          sock.close
        rescue
          sock.close
          return
        end
      end
    end
  end

  def local_request?
    false
  end

  def save_preferences
    @user.preferences = @preferences
    @user.write
  end

  def save_or_delete_record( table, pkeys, values, &block )
    if values[:delete]
      return delete_record( table, pkeys )
    else
      return save_record( table, pkeys, values, &block )
    end
  end

  def save_record( table, pkeys, values, &block )
    if table.select( pkeys ) != 1
      table.create
      pkeys.each do | field_name, value |
        table[field_name] = value
      end
    end
    values.each do | field_name, value |
      next if pkeys.key?(field_name.to_sym)
      next unless table.fields.member?( field_name.to_sym )
      table[field_name] = value
    end
    yield( table ) if block_given?
    return table.write
  end

  def delete_record( table, pkeys )
    if table.select( pkeys ) == 1
      return table.delete
    elsif table.length > 1
      raise "deleting multiple records is forbidden"
    end
    false
  end

end
