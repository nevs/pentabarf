module Momomoto
  class Ui_message < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :ui_message_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :tag => Datatype::Varchar.new( {:not_null=>true, :length=>128} )
      }
    end
  end
end
