module Momomoto
  class Account_forgot_password < Base
    def initialize
      super
      @domain = 'public'
      @query = "SELECT account_forgot_password AS person_id, 
                       %activation_string% AS activation_string
                  FROM account_forgot_password(%person_id%, %activation_string%)"
      @fields = {
        :person_id          => Datatype::Integer.new({:parameter=>true}),
        :activation_string  => Datatype::Char.new({:parameter=>true,:length=>64})
      }
    end
  end
end

