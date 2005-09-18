module Momomoto
  class Team < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :team_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :tag => Datatype::Varchar.new( {:not_null=>true, :length=>32} ),
        :conference_id => Datatype::Integer.new( {:not_null=>true} ),
        :rank => Datatype::Integer.new( {} )
      }
    end
  end
end
