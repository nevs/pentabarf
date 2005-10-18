module Momomoto
  class Conflict_level < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :conflict_level_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :tag => Datatype::Varchar.new( {:not_null=>true, :length=>64} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
