module Momomoto
  class Mime_type < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :mime_type_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :mime_type => Datatype::Varchar.new( {:not_null=>true, :length=>128} ),
        :file_extension => Datatype::Varchar.new( {:length=>16} ),
        :f_image => Datatype::Bool.new( {:not_null=>true, :default=>true} )
      }
    end
  end
end
