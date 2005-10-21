module Momomoto
  class View_paper < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :event_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>256} ),
        :f_paper => Datatype::Bool.new( {} ),
        :paper_submitted => Datatype::Integer.new( {} )
      }
    end
  end
end
