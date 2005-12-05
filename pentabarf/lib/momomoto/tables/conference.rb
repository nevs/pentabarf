module Momomoto
  class Conference < Base
    def initialize
      super
      @domain = 'conference'
      @order = 'lower(acronym)'
      @log_changes = true
      @fields = {
        :conference_id => Datatype::Integer.new( {:not_null=>true, :default=>true, :primary_key=>true, :serial=>true} ),
        :acronym => Datatype::Varchar.new( {:not_null=>true, :length=>16} ),
        :title => Datatype::Varchar.new( {:not_null=>true, :length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>128} ),
        :conference_phase_id => Datatype::Integer.new( {:not_null=>true} ),
        :start_date => Datatype::Date.new( {:not_null=>true} ),
        :days => Datatype::Smallint.new( {:not_null=>true, :default=>true} ),
        :venue => Datatype::Varchar.new( {:length=>64} ),
        :city => Datatype::Varchar.new( {:length=>64} ),
        :country_id => Datatype::Integer.new( {} ),
        :time_zone_id => Datatype::Integer.new( {} ),
        :currency_id => Datatype::Integer.new( {} ),
        :timeslot_duration => Datatype::Interval.new( {} ),
        :default_timeslots => Datatype::Integer.new( {:not_null=>true, :default=>true} ),
        :max_timeslot_duration => Datatype::Integer.new( {} ),
        :day_change => Datatype::Time.new( {:not_null=>true, :default=>true} ),
        :remark => Datatype::Text.new( {} ),
        :f_deleted => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :release => Datatype::Varchar.new( {:length=>32} ),
        :export_base_url => Datatype::Varchar.new( {:length=>256} ),
        :export_css_file => Datatype::Varchar.new( {:length=>256} ),
        :feedback_base_url => Datatype::Varchar.new( {:length=>256} ),
        :css => Datatype::Text.new( {} ),
        :f_feedback_enabled => Datatype::Bool.new( {:not_null=>true, :default=>true} ),
        :last_modified => Datatype::Timestamp.new( {:with_timezone=>true, :not_null=>true, :default=>true, :auto_update=>true} ),
        :last_modified_by => Datatype::Integer.new( {} )
      }
    end
  end
end
