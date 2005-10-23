module Momomoto
  class View_conference_language < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :language_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Varchar.new( {} ),
        :translated_id => Datatype::Integer.new( {} )
      }
    end
  end
end
