module Momomoto
  class View_conference_image_modification < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :conference_id => Datatype::Integer.new( {} ),
        :last_modified=> Datatype::Timestamp.new( {} )
      }
    end
  end
end
