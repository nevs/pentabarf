# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  session :off
  before_filter :authorize

  # extract authorization credentials from http header
  def http_auth_data
    ['X-HTTP_AUTHORIZATION','HTTP_AUTHORIZATION','REDIRECT_X_HTTP_AUTHORIZATION','Authorization'].each do | key |
      if request.env.has_key?( key )
        authdata = request.env[ key ].to_s.split
        if authdata[0] == 'Basic'
          user, pass = Base64.decode64(authdata[1]).split(':', 2)[0..1]
          user = Iconv.iconv( 'UTF-8', 'iso-8859-1', user.to_s )
          pass = Iconv.iconv( 'UTF-8', 'iso-8859-1', pass.to_s )
          return user, pass
        end
        break
      end
    end
    return '', ''
  end

  def authorize
    user, pass = http_auth_data
    @user = User.auth( user, pass )
    return true
   rescue
    response.headers["Status"] = "Unauthorized"
    response.headers["WWW-Authenticate"] = "Basic realm=Pentabarf"
    render_text( "Authentication failed", 401)
    return false
  end

  def log_error( exception, verbose = false )
    super( exception )

    message = ''
    message += "User: #{@user.login_name}\n" if @user 
    message += "Time: #{Time.now.to_s}\n"
    message += "UA: #{request.env['HTTP_USER_AGENT']}\nIP: #{request.remote_ip}\n"
    message += "URL: https://#{request.host + request.request_uri}\n"
    message += "Exception: #{exception.message}\n"
    message += "Exception Class: #{exception.class}\n"
    if verbose
      message += "Backtrace:\n" + clean_backtrace(exception).join("\n") + 
                 "Request: #{filter_parameters(params).inspect}\n"
    end

    begin
      JabberLogger.log( message )
    rescue => e 
      logger.error(e)
    end
  end



end

