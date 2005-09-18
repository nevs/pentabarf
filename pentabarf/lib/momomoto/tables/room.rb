module Momomoto
  class Room < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :room_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :conference_id => Datatype::Integer.new( {:not_null=>true} ),
        :short_name => Datatype::Varchar.new( {:not_null=>true, :length=>32} ),
        :f_public => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :size => Datatype::Integer.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
