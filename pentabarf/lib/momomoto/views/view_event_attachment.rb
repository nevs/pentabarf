module Momomoto
  class View_event_attachment < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_attachment_id => Datatype::Integer.new( {} ),
        :attachment_type_id => Datatype::Integer.new( {} ),
        :attachment_type => Datatype::Varchar.new( {} ),
        :attachment_type_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_id => Datatype::Integer.new( {} ),
        :mime_type_id => Datatype::Integer.new( {} ),
        :mime_type_tag => Datatype::Varchar.new( {:length=>128} ),
        :mime_type => Datatype::Varchar.new( {:length=>128} ),
        :filename => Datatype::Varchar.new( {:length=>256} ),
        :title => Datatype::Varchar.new( {:length=>256} ),
        :f_public => Datatype::Bool.new( {} ),
        :last_changed => Datatype::Timestamp.new( {} ),
        :filesize => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} )
      }
    end
  end
end
