module Momomoto
  class Conflict < Base
    def initialize
      super
      @domain = 'conflict'
      @fields = {
        :conflict_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :conflict_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :tag => Datatype::Varchar.new( {:length=>64} )
      }
    end
  end
end
