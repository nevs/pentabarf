module Momomoto
  class Account_password_reset < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :activation_string => Datatype::Char.new( {:length=>64, :not_null=>true} ),
        :password_reset => Datatype::Datetime.new( {:with_timezone=>true, :default=>true, :not_null=>true} )
      }
    end
  end
end
