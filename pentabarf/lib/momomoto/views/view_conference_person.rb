module Momomoto
  class View_conference_person < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :conference_person_id => Datatype::Integer.new( {} ),
        :person_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :abstract => Datatype::Text.new( {} ),
        :description => Datatype::Text.new( {} ),
        :remark => Datatype::Text.new( {} ),
        :email_public => Datatype::Varchar.new( {:length=>64} )
      }
    end
  end
end
