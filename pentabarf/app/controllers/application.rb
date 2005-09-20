# The filters added to this controller will be run for all controllers in the application.
# Likewise will all the methods added be available for all controllers.

require 'zlib'
require 'stringio'
require 'socket'

class ApplicationController < ActionController::Base

  @@version = "0.2"
  @@base_url = "https://pentabarf.cccv.de/"

  def get_auth_data 
    login_name, password = '', '' 
    # extract authorisation credentials 
    if request.env.has_key? 'X-HTTP_AUTHORIZATION' 
      # try to get it where mod_rewrite might have put it 
      authdata = @request.env['X-HTTP_AUTHORIZATION'].to_s.split 
    elsif request.env.has_key? 'HTTP_AUTHORIZATION' 
      # this is the regular location 
      authdata = @request.env['HTTP_AUTHORIZATION'].to_s.split  
    elsif request.env.has_key? 'Authorization' 
      # this is the regular location 
      authdata = @request.env['Authorization'].to_s.split  
    end 
     
    # at the moment we only support basic authentication 
    if authdata and authdata[0] == 'Basic' 
      login_name, password = Base64.decode64(authdata[1]).split(':')[0..1] 
    end 
    return [login_name, password] 
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
      render_text(errormessage, 401)       
    end 
    return false
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
    if output.length < response.body.length 
      response.body = output.string 
      response.headers['Content-encoding'] = encoding 
    end 
  end 

  def rescue_action_in_public( exception )
    render :file => '../app/views/meditation.rhtml'
  end

  def log_error( exception )
    super( exception )

    message = ''
    message += "User: #{@user.login_name}\n" if @user != nil 
    message += "IP: #{@request.remote_ip}\n"
    message += "URL: https://#{@request.host + @request.request_uri}\n"
    message += "Exception: #{exception.to_s}\n"
    message += "Backtrace:\n"
    clean_backtrace(exception).each do | line | 
      message += "#{line}\n"
    end

    begin
      ApplicationController.jabber_message( message )
    rescue => e
      logger.error(e)
    end
  end

  def self.jabber_message( text )
    config = YAML.load_file( '../config/jabber.yml' )

    config['recipients'].each do | recipient |
      begin
        sock = UNIXSocket.open(config['daemon']['socket_path'])
      rescue
        return
      end
      msg = Jabber::Message.new(Jabber::JID.new(recipient))
      msg.set_type(:chat)
      msg.set_body( text )
      sock.send(msg.to_s, 0)
      sock.close
    end
  end

  def local_request?
    false
  end

end
