module Momomoto
  class View_expenses < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :travel_cost => Datatype::Numeric.new( {} ),
        :travel_currency_id => Datatype::Integer.new( {} ),
        :travel_currency_name => Datatype::Varchar.new( {} ),
        :accommodation_cost => Datatype::Numeric.new( {} ),
        :accommodation_currency_id => Datatype::Integer.new( {} ),
        :accommodation_currency_name => Datatype::Varchar.new( {} ),
        :fee => Datatype::Numeric.new( {} ),
        :fee_currency_id => Datatype::Integer.new( {} ),
        :fee_currency_name => Datatype::Varchar.new( {} ),
        :language_id => Datatype::Integer.new( {} )
      }
    end
  end
end
