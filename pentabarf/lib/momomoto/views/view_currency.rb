module Momomoto
  class View_currency < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :currency_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Char.new( {:length=>3} ),
        :name => Datatype::Varchar.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
