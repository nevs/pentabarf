module Momomoto
  class Phone_type_localized < Base
    def initialize
      super
      @domain = 'localization'
      @fields = {
        :phone_type_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :language_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :name => Datatype::Varchar.new( {:not_null=>true, :length=>64} )
      }
    end
  end
end
