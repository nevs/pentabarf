class Person < Momomoto::Table

  module Methods

    def password=( value )
      srand()
      salt = []
      8.times do salt << rand(256) end

      salt_bin, salt_hex = '', ''
      for number in salt
        salt_bin += sprintf('%c', number)
        salt_hex += sprintf('%02x', number)
      end

      hash = Digest::MD5.hexdigest( salt_bin + value.to_s )
      set_column( :password, salt_hex + hash )
    end

  end
end
