# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'iconv'

class ApplicationController < ActionController::Base

  protected

  def log_error( e )
    super( e )
    message = ''
    message += "Time: #{Time.now.to_s}\n"
    message += "UA: #{request.env['HTTP_USER_AGENT']}\n"
    message += "IP: #{request.remote_ip}\n"
    message += "URL: https://#{request.host + request.request_uri}\n"
    message += "Exception: #{e.message}\n"
    message += "Backtrace:\n#{clean_backtrace(e).join("\n")}\n"
    message += "Request: #{params.inspect}\n"

    JabberLogger.log( message )
  end

  # klass is the class derived from Momomoto::Table in which to store the data.
  # values is a hash with the values for this table
  # preset is a hash with field_name : value pairs which are always true
  def write_table( klass, values, preset )
    values.each do | row_id, hash |
      next if row_id == 'row_id'
      row = klass.select_or_new( preset ) do | field | hash[field] end
      if hash['remove']
        row.delete if not row.new_record?
        next
      end
      hash.each do | field, value |
        next if klass.primary_keys.member?( field.to_sym ) || [:event_id].member?( field.to_sym )
        row[ field ] = value
      end
      row.write
    end
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

end

