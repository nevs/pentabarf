module Momomoto
  class Ui_message_localized < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :ui_message_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :language_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :name => Datatype::Text.new( {:not_null=>true} )
      }
    end
  end
end
