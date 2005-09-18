module Momomoto
  class View_team < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :team_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Varchar.new( {} ),
        :rank => Datatype::Integer.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
