module Momomoto
  class Currency < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :currency_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :iso_4217_code => Datatype::Char.new( {:length=>3, :not_null=>true} ),
        :f_default => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_visible => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_preferred => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :exchange_rate => Datatype::Numeric.new( {} )
      }
    end
  end
end
