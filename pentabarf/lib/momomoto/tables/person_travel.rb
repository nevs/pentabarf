module Momomoto
  class Person_travel < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :conference_id => Datatype::Integer.new( {:not_null=>true, :primary_key=>true} ),
        :arrival_transport_id => Datatype::Integer.new( {} ),
        :arrival_from => Datatype::Varchar.new( {:length=>64} ),
        :arrival_to => Datatype::Varchar.new( {:length=>64} ),
        :arrival_number => Datatype::Varchar.new( {:length=>32} ),
        :arrival_date => Datatype::Date.new( {} ),
        :arrival_time => Datatype::Time.new( {:with_timezone=>true} ),
        :f_arrival_pickup => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :f_departure_pickup => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :departure_transport_id => Datatype::Integer.new( {} ),
        :departure_from => Datatype::Varchar.new( {:length=>64} ),
        :departure_to => Datatype::Varchar.new( {:length=>64} ),
        :departure_number => Datatype::Varchar.new( {:length=>32} ),
        :departure_date => Datatype::Date.new( {} ),
        :departure_time => Datatype::Time.new( {:with_timezone=>true} ),
        :travel_cost => Datatype::Numeric.new( {} ),
        :travel_currency_id => Datatype::Integer.new( {:not_null=>true} ),
        :accommodation_cost => Datatype::Numeric.new( {} ),
        :accommodation_currency_id => Datatype::Integer.new( {:not_null=>true} ),
        :accommodation_name => Datatype::Varchar.new( {:length=>64} ),
        :accommodation_street => Datatype::Varchar.new( {:length=>64} ),
        :accommodation_postcode => Datatype::Varchar.new( {:length=>10} ),
        :accommodation_city => Datatype::Varchar.new( {:length=>64} ),
        :accommodation_phone => Datatype::Varchar.new( {:length=>32} ),
        :accommodation_phone_room => Datatype::Varchar.new( {:length=>32} ),
        :f_arrived => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :fee => Datatype::Numeric.new( {} ),
        :fee_currency_id => Datatype::Integer.new( {:not_null=>true} )
      }
    end
  end
end
