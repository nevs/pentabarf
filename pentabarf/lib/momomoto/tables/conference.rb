module Momomoto
  class Conference < Base
    def initialize
      super
      @domain = 'conference'
      @order = 'lower(acronym)'
      @fields = {
        :conference_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :acronym => Datatype::Varchar.new( {:not_null=>true, :length=>16} ),
        :title => Datatype::Varchar.new( {:not_null=>true, :length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>128} ),
        :start_date => Datatype::Date.new( {:not_null=>true} ),
        :days => Datatype::Smallint.new( {:not_null=>true, :default=>true} ),
        :venue => Datatype::Varchar.new( {:length=>64} ),
        :city => Datatype::Varchar.new( {:length=>64} ),
        :country_id => Datatype::Integer.new( {} ),
        :time_zone_id => Datatype::Integer.new( {} ),
        :currency_id => Datatype::Integer.new( {} ),
        :primary_language_id => Datatype::Integer.new( {} ),
        :secondary_language_id => Datatype::Integer.new( {} ),
        :timeslot_duration => Datatype::Interval.new( {} ),
        :max_timeslot_duration => Datatype::Integer.new( {} ),
        :day_change => Datatype::Time.new( {:not_null=>true, :default=>true} ),
        :remark => Datatype::Text.new( {} ),
        :f_deleted => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :release => Datatype::Varchar.new( {:length=>32} ),
        :export_base_url => Datatype::Varchar.new( {:length=>256} ),
        :export_css_file => Datatype::Varchar.new( {:length=>256} ),
        :feedback_base_url => Datatype::Varchar.new( {:length=>256} ),
        :css => Datatype::Text.new( {} )
      }
    end
  end
end
