module Momomoto
  class Phone_type < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :phone_type_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :tag => Datatype::Varchar.new( {:not_null=>true, :length=>32} ),
        :scheme => Datatype::Varchar.new( {:length=>32} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
