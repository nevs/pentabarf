module Momomoto
  class View_schedule_person < Base
    def initialize
      super
      @domain = 'person'
      @order = 'lower(name), lower(title), lower(subtitle)'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :event_id => Datatype::Integer.new( {} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>256} ),
        :conference_id => Datatype::Integer.new( {} ),
        :conference_person_id => Datatype::Integer.new( {} ),
        :abstract => Datatype::Text.new( {} ),
        :description => Datatype::Text.new( {} ),
        :email_public => Datatype::Varchar.new( {:length=>64} ),
        :f_public => Datatype::Bool.new( {} ),
        :file_extension => Datatype::Varchar.new( {:length=>16} )
      }
    end
  end
end
