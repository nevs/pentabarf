module Momomoto
  class Conference_image < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :conference_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :mime_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :image => Datatype::Bytea.new( {:not_null=>true} ),
        :last_changed => Datatype::Timestamp.new( {:not_null=>true, :default=>true} )
      }
    end
  end
end
