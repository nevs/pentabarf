module Momomoto
  class View_country < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :country_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Char.new( {:length=>2} ),
        :name => Datatype::Varchar.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
