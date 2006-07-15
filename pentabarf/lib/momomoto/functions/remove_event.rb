module Momomoto
  class Remove_event < Base
    def initialize
      super
      @domain = 'event'
      @query = "SELECT remove_event AS event_id
                  FROM remove_event( %event_id% )"
      @fields = {
        :event_id       => Datatype::Integer.new({:parameter=>true}),
      }
    end
  end
end

