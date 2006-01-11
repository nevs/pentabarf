require 'datatype/base'
require 'digest/md5'

module Momomoto
  module Datatype

    class Password < Char

      def filter_set( value )
        value = value.to_s
        return @value if value == ''
        srand()
        salt = []
        for i in 0..7
          salt[i] = rand(256)
        end
        salt_bin, salt_hex = '', ''
        for number in salt
          salt_bin += sprintf('%c', number)
          salt_hex += sprintf('%02x', number)
        end
        hash = Digest::MD5.hexdigest( salt_bin + value )
        return salt_hex + hash
      end


    end

  end
end

