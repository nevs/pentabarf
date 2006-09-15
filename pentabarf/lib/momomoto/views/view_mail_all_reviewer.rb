module Momomoto
  class View_mail_all_reviewer < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :email_contact => Datatype::Varchar.new( {:length=>64} )
      }
    end
  end
end
