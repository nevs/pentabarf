module Momomoto
  class Person_image < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :mime_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :f_public => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :image => Datatype::Bytea.new( {:not_null=>true} ),
        :last_changed => Datatype::Timestamp.new( {:not_null=>true, :default=>true} )
      }
    end
  end
end
