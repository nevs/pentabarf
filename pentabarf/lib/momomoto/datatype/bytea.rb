
require 'datatype/base'

module Momomoto 
  module Datatype

    class Bytea < Base 
    
      def filter_read( value )
        PGconn.unescape_bytea( value )
      end

      def filter_write( value )
        "'" + PGconn.escape_bytea( value ) + "'"
      end

    end
    
  end
end

