module Momomoto
  class View_report_pickup < Base
    def initialize
      super
      @domain = 'person'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :language_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :type => Datatype::Text.new( {} ),
        :from => Datatype::Varchar.new( {} ),
        :to => Datatype::Varchar.new( {} ),
        :transport_id => Datatype::Integer.new( {} ),
        :transport => Datatype::Varchar.new( {} ),
        :transport_tag => Datatype::Varchar.new( {} ),
        :date => Datatype::Date.new( {} ),
        :time => Datatype::Time.new( {:with_timezone=>true} ),
        :number => Datatype::Varchar.new( {} )
      }
    end
  end
end
