module Momomoto
  class View_schedule_person < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :abstract => Datatype::Text.new( {} ),
        :description => Datatype::Text.new( {} ),
        :email_public => Datatype::Varchar.new( {:length=>64} )
      }
    end
  end
end
