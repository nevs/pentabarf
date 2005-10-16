module Momomoto
  class View_conflict < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :conflict_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>64} ),
        :name => Datatype::Text.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
