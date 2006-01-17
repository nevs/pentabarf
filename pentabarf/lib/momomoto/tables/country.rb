module Momomoto
  class Country < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :country_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :iso_3166_code => Datatype::Char.new( {:length=>2, :not_null=>true} ),
        :phone_prefix => Datatype::Varchar.new( {:length=>8} ),
        :f_visible => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_preferred => Datatype::Bool.new( {:not_null=>true, :default=>true} )
      }
    end
  end
end
