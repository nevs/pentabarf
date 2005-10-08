module Momomoto
  class View_conference_phase < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :conference_phase_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Varchar.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
