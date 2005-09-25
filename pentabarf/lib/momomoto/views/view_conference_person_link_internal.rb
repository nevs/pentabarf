module Momomoto
  class View_conference_person_link_internal < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :conference_person_link_internal_id => Datatype::Integer.new( {} ),
        :conference_person_id => Datatype::Integer.new( {} ),
        :link_type_id => Datatype::Integer.new( {} ),
        :url => Datatype::Text.new( {} ),
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
