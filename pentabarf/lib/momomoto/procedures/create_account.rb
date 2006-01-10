module Momomoto
  class Create_account < Base
    def initialize
      super
      @domain = 'public'
      @query = "SELECT create_account AS new_person_id, 
                       %login_name% AS login_name,
                       %email_contact% AS email_contact,
                       %password% AS password,
                       %activation_string% AS activation_string
                  FROM create_account( %login_name%, %email_contact%, %password%, %activation_string%)"
      @fields = {
        :new_person_id      => Datatype::Integer.new({}),
        :login_name         => Datatype::Varchar.new({:parameter=>true,:length=>32}),
        :email_contact      => Datatype::Varchar.new({:parameter=>true,:length=>64}),
        :password           => Datatype::Password.new({:parameter=>true}),
        :activation_string  => Datatype::Char.new({:parameter=>true,:length=>64})
      }
    end
  end
end

