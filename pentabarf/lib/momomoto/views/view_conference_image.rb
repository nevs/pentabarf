module Momomoto
  class View_conference_image < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :conference_id => Datatype::Integer.new( {} ),
        :mime_type_id => Datatype::Integer.new( {} ),
        :mime_type => Datatype::Varchar.new( {:length=>128} ),
        :image => Datatype::Bytea.new( {} ),
        :last_changed => Datatype::Timestamp.new( {} )
      }
    end
  end
end
