module Momomoto
  class View_person_image_modification < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :last_modified=> Datatype::Timestamp.new( {} )
      }
    end
  end
end
