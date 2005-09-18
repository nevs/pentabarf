module Momomoto
  class View_find_conference < Base
    def initialize
      super
      @domain = 'conference'
      @order = 'lower(title),lower(subtitle)'
      @fields = {
        :search => Datatype::Textsearch.new( {:virtual=>true,:field=>[:title,:subtitle,:acronym]} ),
        :conference_id => Datatype::Integer.new( {} ),
        :acronym => Datatype::Varchar.new( {:length=>16} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>128} ),
        :start_date => Datatype::Date.new( {} ),
        :days => Datatype::Smallint.new( {} ),
        :venue => Datatype::Varchar.new( {:length=>64} ),
        :city => Datatype::Varchar.new( {:length=>64} ),
        :mime_type_id => Datatype::Integer.new( {} ),
        :mime_type => Datatype::Varchar.new( {:length=>128} ),
        :file_extension => Datatype::Varchar.new( {:length=>16} )
      }
    end
  end
end
