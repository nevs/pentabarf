module Momomoto
  class Conference_image < Base
    def initialize
      super
      @domain = 'conference'
      @log_changes = true
      @fields = {
        :conference_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :mime_type_id => Datatype::Integer.new( {:not_null=>true} ),
        :image => Datatype::Bytea.new( {:not_null=>true} ),
        :last_modified => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true, :auto_update=>true} ),
        :last_modified_by => Datatype::Integer.new( {} )
      }
    end
  end
end
