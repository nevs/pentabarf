require 'digest/md5'

module Momomoto
  class Person < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :login_name => Datatype::Varchar.new( {:length=>32} ),
        :password => Datatype::Password.new( {:length=>48} ),
        :title => Datatype::Varchar.new( {:length=>32} ),
        :gender => Datatype::Bool.new( {} ),
        :first_name => Datatype::Varchar.new( {:length=>64} ),
        :middle_name => Datatype::Varchar.new( {:length=>64} ),
        :last_name => Datatype::Varchar.new( {:length=>64} ),
        :public_name => Datatype::Varchar.new( {:length=>64} ),
        :nickname => Datatype::Varchar.new( {:length=>64} ),
        :address => Datatype::Varchar.new( {:length=>256} ),
        :street => Datatype::Varchar.new( {:length=>64} ),
        :street_postcode => Datatype::Varchar.new( {:length=>10} ),
        :po_box => Datatype::Varchar.new( {:length=>10} ),
        :po_box_postcode => Datatype::Varchar.new( {:length=>10} ),
        :city => Datatype::Varchar.new( {:length=>64} ),
        :country_id => Datatype::Integer.new( {} ),
        :email_contact => Datatype::Varchar.new( {:length=>64} ),
        :iban => Datatype::Varchar.new( {:length=>128} ),
        :bank_name => Datatype::Varchar.new( {:length=>128} ),
        :account_owner => Datatype::Varchar.new( {:length=>128} ),
        :gpg_key => Datatype::Text.new( {} ),
        :preferences => Datatype::Preferences.new( {} ),
        :f_conflict => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_deleted => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_spam => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :last_login => Datatype::Timestamp.new( {:with_timezone=>true} ),
        :bic => Datatype::Varchar.new( {:length=>32} )
      }
    end

  end
end
