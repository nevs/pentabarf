# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base

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

end
