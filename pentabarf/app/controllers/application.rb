# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  session(:off)

  protected

  def log_error( e )
    super( e )

    message = ''
    message += "Time: #{Time.now.to_s}\n"
    message += "UA: #{request.env['HTTP_USER_AGENT']}\n"
    message += "IP: #{request.remote_ip}\n"
    message += "URL: https://#{request.host + request.request_uri}\n"
    message += "Exception: #{e.message}\n"
    message += "Exception Class: #{e.class}\n"
    message += "Backtrace:\n"
    message += clean_backtrace(e).join("\n")
    message += "\n"
    message += "Request: #{params.inspect}\n"

    JabberLogger.log( message )
  end

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
    login_name = Iconv.iconv('UTF-8', 'iso-8859-1', login_name.to_s)
    password = Iconv.iconv('UTF-8', 'iso-8859-1', password.to_s)
    return [login_name.to_s, password.to_s]
  end

end

