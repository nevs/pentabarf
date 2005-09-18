module Momomoto
  class View_last_active < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :login_name => Datatype::Varchar.new( {:length=>32} ),
        :name => Datatype::Varchar.new( {} ),
        :last_login => Datatype::Timestamp.new( {:with_timezone=>true} ),
        :login_diff => Datatype::Interval.new( {} )
      }
    end
  end
end
