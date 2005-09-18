module Momomoto
  class View_person_link < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_link_id => Datatype::Integer.new( {} ),
        :person_id => Datatype::Integer.new( {} ),
        :link_type_id => Datatype::Integer.new( {} ),
        :url => Datatype::Varchar.new( {:length=>1024} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :description => Datatype::Varchar.new( {:length=>128} ),
        :rank => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :url_prefix => Datatype::Varchar.new( {:length=>1024} ),
        :f_public => Datatype::Bool.new( {} ),
        :tag => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Varchar.new( {} )
      }
    end
  end
end
