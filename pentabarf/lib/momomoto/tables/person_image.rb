module Momomoto
  class Person_image < Base
    def initialize
      super
      @domain = 'person'
      @log_changes = true
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :mime_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :f_public => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :image => Datatype::Bytea.new( {:not_null=>true} ),
        :last_modified => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true, :auto_update=>true} ),
        :last_modified_by => Datatype::Integer.new( {} )
      }
    end
  end
end
