module Momomoto
  class View_mime_type < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :mime_type_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>128} ),
        :mime_type => Datatype::Varchar.new( {:length=>128} ),
        :name => Datatype::Varchar.new( {:length=>128} ),
        :file_extension => Datatype::Varchar.new( {:length=>16} ),
        :f_image => Datatype::Bool.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
