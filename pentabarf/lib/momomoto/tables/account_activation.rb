module Momomoto
  class Account_activation < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :account_activation_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :person_id => Datatype::Integer.new( {:not_null=>true} ),
        :activation_string => Datatype::Char.new( {:not_null=>true, :length=>64} ),
        :account_creation => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true} )
      }
    end
  end
end
