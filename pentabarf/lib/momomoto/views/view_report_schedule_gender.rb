module Momomoto
  class View_report_schedule_gender < Base
    def initialize
      super
      @domain = 'event'
      @fields = {
        :person_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :gender => Datatype::Bool.new( {} )
      }
    end
  end
end
