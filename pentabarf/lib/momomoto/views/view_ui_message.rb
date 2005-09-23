module Momomoto
  class View_ui_message < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :ui_message_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>128} ),
        :name => Datatype::Text.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
