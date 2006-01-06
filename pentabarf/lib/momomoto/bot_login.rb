module Momomoto

  class Bot_login < Base

    def initialize
      super
      @table = 'person'
      @domain = 'own_person'
      @fields = { :person_id    => Datatype::Integer.new( {:primary_key => true, :not_null => true, :serial => true} ),
                  :login_name   => Datatype::Varchar.new( {} ),
                  :preferences  => Datatype::Preferences.new( {} )
      }
    end

    def self.authorize( login_name )
      bot = self.new
      bot.authorize( login_name )
      bot
    end

    def authorize( login_name )
      if login_name.to_s != '' && select( { :login_name => login_name } ) == 1
        @@person_id = self[:person_id].to_i
        @@permissions = execute("SELECT get_permissions from get_permissions('#{@@person_id}');").to_a.flatten
        Base.ui_language_id= self[:preferences][:current_language_id]
        return true
      end
      @resultset = []
      false
    end

  end
end
