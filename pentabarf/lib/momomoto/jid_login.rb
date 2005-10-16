module Momomoto

  class Login < Base

    def initialize
      super
      @table = 'view_jid_login'
      @domain = 'person'
      @fields = {
        :person_im_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true, :serial=>true} ),
        :person_id => Datatype::Integer.new( {:not_null=>true} ),
        :im_address => Datatype::Varchar.new( {:not_null=>true, :length=>128} ),
        :name => Datatype::Text.new( {} ),
        :preferences => Datatype::Preferences.new( {} )
      }
    end

    def self.authorize( jid )
      login = self.new
      login.authorize( jid )
      login
    end

    def authorize( jid )
      if jid.to_s != '' && select( { :im_address => jid } ) == 1
        @@person_id = self[:person_id].to_i
        @@permissions = execute("SELECT get_permissions from get_permissions('#{@@person_id}');").to_a.flatten
        self.ui_language_id= self[:preferences][:current_language_id]
        return true
      end
      false
    end

    def dirty?()
      false
    end

  end
end
