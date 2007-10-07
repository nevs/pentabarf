# class that handles token generation
class Token
  class << self

    def generate( url )
      salt = POPE.user.password[0..15] rescue ""
#      puts "Token: URL: #{url} salt: '#{salt}'"
      Digest::SHA1.hexdigest( url + Digest::SHA1.hexdigest( salt ) )
    end

  end
end
