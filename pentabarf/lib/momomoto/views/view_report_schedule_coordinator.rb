module Momomoto
  class View_report_schedule_coordinator < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :count => Datatype::Integer.new( {} ),
        :person_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} )
      }
    end
  end
end
