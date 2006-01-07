module Momomoto
  class New_account < Base
    def initialize
      super
      @domain = 'public'
      @fields = {
        :new_account_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :login_name => Datatype::Varchar.new( {:not_null=>true, :length=>32} ),
        :email_contact => Datatype::Varchar.new( {:not_null=>true, :length=>64} ),
        :password => Datatype::Password.new( {:not_null=>true, :length=>48} ),
        :activation_string => Datatype::Char.new( {:not_null=>true, :length=>64} ),
        :account_creation => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true} )
      }
    end
  end
end
