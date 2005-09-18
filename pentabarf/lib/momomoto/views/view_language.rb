module Momomoto
  class View_language < Base
    def initialize
      super
      @domain = 'valuelist'
      @order = 'lower(name)'
      @fields = {
        :translated_id => Datatype::Integer.new( {} ),
        :iso_639_code => Datatype::Char.new( {:length=>3} ),
        :tag => Datatype::Varchar.new( {:length=>32} ),
        :f_default => Datatype::Bool.new( {} ),
        :f_localized => Datatype::Bool.new( {} ),
        :f_visible => Datatype::Bool.new( {} ),
        :f_preferred => Datatype::Bool.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :language_tag => Datatype::Varchar.new( {:length=>32} )
      }
    end
  end
end
