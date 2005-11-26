module Momomoto
  class View_event_image_modification < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_id => Datatype::Integer.new( {} ),
        :last_modified=> Datatype::Timestamp.new( {} )
      }
    end
  end
end
