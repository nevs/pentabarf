module Momomoto
  class Conference_link < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :conference_link_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :conference_id => Datatype::Integer.new( {:not_null=>true} ),
        :url => Datatype::Varchar.new( {:not_null=>true, :length=>1024} ),
        :description => Datatype::Varchar.new( {:length=>256} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
