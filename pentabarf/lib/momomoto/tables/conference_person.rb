module Momomoto
  class Conference_person < Base
    def initialize
      super
      @domain = 'person'
      @log_changes = true
      @fields = {
        :conference_person_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :conference_id => Datatype::Integer.new( {:not_null=>true} ),
        :person_id => Datatype::Integer.new( {:not_null=>true} ),
        :abstract => Datatype::Text.new( {} ),
        :description => Datatype::Text.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :email_public => Datatype::Varchar.new( {:length=>64} ),
        :f_reconfirmed => Datatype::Bool.new( {:not_null=>true, :default=>false} ),
        :last_modified => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true, :auto_update=>true} ),
        :last_modified_by => Datatype::Integer.new( {} )
      }
    end
  end
end
