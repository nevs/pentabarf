module Momomoto
  class View_room < Base
    def initialize
      super
      @domain = 'conference'
      @fields = {
        :room_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Varchar.new( {} ),
        :f_public => Datatype::Bool.new( {} ),
        :size => Datatype::Integer.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :rank => Datatype::Integer.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
