# class that handles token generation
class Token
  class << self

    def generate( url )
      Digest::SHA1.hexdigest( url + Digest::SHA1.hexdigest( POPE.user.password[0..15] ) )
    end

  end
end
