module Momomoto
  class View_find_event < Base
    def initialize
      super
      @domain = 'event'
      @order = 'lower(title),lower(subtitle)'
      @allow_empty = true
      @fields = {
        :s_title => Datatype::Textsearch.new( {:virtual=>true,:field=>[:title,:subtitle]} ),
        :s_description => Datatype::Textsearch.new( {:virtual=>true,:field=>[:abstract,:description]} ),
        :s_coordinator => Datatype::Keysearch.new( {:virtual=>true,:key_field=>'event_id',:subselect=>"SELECT event_id FROM event_person INNER JOIN event_role USING(event_role_id) WHERE event_role.tag = 'coordinator' AND event_person.person_id IN (%%%)"} ),
        :s_speaker => Datatype::Keysearch.new( {:virtual=>true,:key_field=>'event_id',:subselect=>"SELECT event_id FROM event_person INNER JOIN event_role USING(event_role_id) WHERE event_role.tag = 'speaker' AND event_person.person_id IN (%%%)"} ),
        :s_moderator => Datatype::Keysearch.new( {:virtual=>true,:key_field=>'event_id',:subselect=>"SELECT event_id FROM event_person INNER JOIN event_role USING(event_role_id) WHERE event_role.tag = 'moderator' AND event_person.person_id IN (%%%)"} ),
        :s_public => Datatype::Boolsearch.new( {:virtual=>true,:field=>:f_public} ),
        :event_id => Datatype::Integer.new( {} ),
        :conference_id => Datatype::Integer.new( {} ),
        :title => Datatype::Varchar.new( {:length=>128} ),
        :subtitle => Datatype::Varchar.new( {:length=>256} ),
        :abstract => Datatype::Text.new( {} ),
        :description => Datatype::Text.new( {} ),
        :duration => Datatype::Interval.new( {} ),
        :event_origin_id => Datatype::Integer.new( {} ),
        :conference_track_id => Datatype::Integer.new( {} ),
        :event_state_id => Datatype::Integer.new( {} ),
        :event_state_progress_id => Datatype::Integer.new( {} ),
        :event_type_id => Datatype::Integer.new( {} ),
        :room_id => Datatype::Integer.new( {} ),
        :day => Datatype::Smallint.new( {} ),
        :start_time => Datatype::Interval.new( {} ),
        :mime_type_id => Datatype::Integer.new( {} ),
        :mime_type => Datatype::Varchar.new( {:length=>128} ),
        :file_extension => Datatype::Varchar.new( {:length=>16} ),
        :language_id => Datatype::Integer.new( {} ),
        :translated_id => Datatype::Integer.new( {} ),
        :event_state_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state => Datatype::Varchar.new( {} ),
        :event_state_progress_tag => Datatype::Varchar.new( {:length=>32} ),
        :event_state_progress => Datatype::Varchar.new( {} ),
        :room_tag => Datatype::Varchar.new( {:length=>32} ),
        :room => Datatype::Varchar.new( {} )
      }
    end
  end
end
