module Momomoto
  class View_time_zone < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :time_zone_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Varchar.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
