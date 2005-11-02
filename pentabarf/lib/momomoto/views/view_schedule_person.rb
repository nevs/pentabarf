module Momomoto
  class View_schedule_person < Base
    def initialize
      super
      @domain = 'person'
      @order = 'lower(name)'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :event_id => Datatype::Integer.new( {} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>256} ),
        :conference_id => Datatype::Integer.new( {} ),
        :abstract => Datatype::Text.new( {} ),
        :description => Datatype::Text.new( {} ),
        :email_public => Datatype::Varchar.new( {:length=>64} )
      }
    end
  end
end
