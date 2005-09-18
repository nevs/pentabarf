module Momomoto
  class View_im_type < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :im_type_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :scheme => Datatype::Varchar.new( {:length=>32} ),
        :tag => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Varchar.new( {} ),
        :rank => Datatype::Integer.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
