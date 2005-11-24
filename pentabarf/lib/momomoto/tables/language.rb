module Momomoto
  class Language < Base
    def initialize
      super
      @domain = 'valuelist'
      @fields = {
        :language_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :iso_639_code => Datatype::Char.new( {:not_null=>true, :length=>3} ),
        :tag => Datatype::Varchar.new( {:not_null=>true, :length=>32} ),
        :f_default => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_localized => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_visible => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_preferred => Datatype::Bool.new( {:not_null=>true, :default=>true} )
      }
    end
  end
end
