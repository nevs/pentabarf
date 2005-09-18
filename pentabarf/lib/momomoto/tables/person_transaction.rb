module Momomoto
  class Person_transaction < Base
    def initialize
      super
      @domain = 'person'
      @limit = 1;
      @order = 'changed_when DESC'
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :changed_when => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true, :primary_key=>true} ),
        :changed_by => Datatype::Integer.new( {:not_null=>true} ),
        :f_create => Datatype::Bool.new( {:not_null=>true, :default=>true} )
      }
    end
  end
end
