# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'momomoto_helper'

class ApplicationController < ActionController::Base
  include MomomotoHelper
  session :off
  around_filter :transaction_wrapper
  before_filter :check_token

  protected

  def local( tag )
    Localizer.lookup( tag.to_s, @current_language )
  end

  def transaction_wrapper
    Momomoto::Database.instance.transaction do
      yield if auth
      POPE.deauth
    end
  end

  def rescue_action_in_public( exception )
    @meditation_message = exception.message
    render :file => File.join( RAILS_ROOT, '/app/views/meditation.rhtml' )
  end

  # extract authorization credentials from http header
  def http_auth_data
    ['X-HTTP_AUTHORIZATION','HTTP_AUTHORIZATION','REDIRECT_X_HTTP_AUTHORIZATION','Authorization'].each do | key |
      if request.env.has_key?( key )
        authdata = request.env[ key ].to_s.split
        if authdata[0] == 'Basic'
          user, pass = Base64.decode64(authdata[1]).split(':', 2)[0..1]
          user = Iconv.iconv( 'UTF-8', 'iso-8859-1', user.to_s ).first
          pass = Iconv.iconv( 'UTF-8', 'iso-8859-1', pass.to_s ).first
          return user, pass
        end
        break
      end
    end
    return '', ''
  end

  def auth
    user, pass = http_auth_data
    POPE.auth( user, pass )
    return check_permission
   rescue
    response.headers["Status"] = "Unauthorized"
    response.headers["WWW-Authenticate"] = "Basic realm=Pentabarf"
    render( :file=>'auth_failed',:status=>401,:use_full_path=>true,:content_type=>'text/html' )
    return false
  end

  def check_permission
    return POPE.permission?('pentabarf_login')
  end

  # protect save and delete functions with token
  def check_token
    if params[:action].match(/^(save|delete)_/)
      token = Token.generate( url_for(:only_path=>true) )
      if token != params[:token]
        warn( "Wrong token for #{url_for()} from #{request.remote_ip}")
        return false
      end
    end
    true
  end

  # check whether we are working on the last version
  def check_transaction
    action = params[:action].gsub(/^save_/, '')
    if params[:transaction].to_i != 0
      transaction = "#{action.capitalize}_transaction".constantize.select_single({"#{action}_id"=>params[:id]},{:limit=>1})
      if transaction["#{action}_transaction_id"] != params[:transaction].to_i
        raise "Simultanious edit"
      end
    end
  end

  def log_error( exception, verbose = false )
    super( exception )

    message = ''
    message += "User: #{POPE.user.login_name}\n" if POPE.user
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

