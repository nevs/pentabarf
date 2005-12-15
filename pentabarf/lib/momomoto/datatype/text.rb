require 'datatype/base'

module Momomoto 
  module Datatype

    class Text < Base 

      def filter_set( data )
        return nil if data == ''
        data.gsub( /\\/, '' ).strip unless data == nil
      end
  
    end
    
  end
end


