module Momomoto
  class View_mail_accepted_speaker < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :email_contact => Datatype::Varchar.new( {:length=>64} ),
        :event_id => Datatype::Integer.new( {} ),
        :event_title => Datatype::Varchar.new( {:length=>128} ),
        :event_subtitle => Datatype::Varchar.new( {:length=>256} ),
        :conference_id => Datatype::Integer.new( {} ),
        :conference_acronym => Datatype::Varchar.new( {:length=>16} ),
        :conference_title => Datatype::Varchar.new( {:length=>128} )
      }
    end
  end
end
