module Momomoto
  class View_conference_track < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :conference_track_id => Datatype::Integer.new( {} ),
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
