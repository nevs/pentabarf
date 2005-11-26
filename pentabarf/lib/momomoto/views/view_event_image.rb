module Momomoto
  class View_event_image < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_id => Datatype::Integer.new( {} ),
        :mime_type_id => Datatype::Integer.new( {} ),
        :mime_type => Datatype::Varchar.new( {:length=>128} ),
        :image => Datatype::Bytea.new( {} ),
        :last_modified=> Datatype::Timestamp.new( {} )
      }
    end
  end
end
