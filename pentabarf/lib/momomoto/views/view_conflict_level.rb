module Momomoto
  class View_conflict_level < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :conflict_level_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>64} ),
        :name => Datatype::Varchar.new( {:length=>64} ),
        :rank => Datatype::Integer.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
