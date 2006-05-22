module Momomoto
  class Account_reset_password < Base
    def initialize
      super
      @domain = 'public'
      @query = "SELECT account_reset_password AS person_id,
                       %login_name% AS login_name,
                       %activation_string% AS activation_string,
                       %password% AS password
                  FROM account_reset_password(%login_name%, %activation_string%, %password%)"
      @fields = {
        :person_id          => Datatype::Integer.new,
        :login_name         => Datatype::Text.new({:parameter=>true}),
        :activation_string  => Datatype::Char.new({:parameter=>true,:length=>64}),
        :password           => Datatype::Password.new( {:parameter=>true,:length=>48} )
      }
    end
  end
end

