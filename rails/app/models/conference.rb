class Conference < Momomoto::Table
  default_order( Momomoto.lower(:acronym) )

  module Methods

    def days( *args )
      conference_day( *args )
    end

    def rooms( *args )
      conference_room( *args )
    end

    def tracks( *args )
      conference_track( *args )
    end

    def releases( *args )
      conference_release( *args )
    end

    def latest_release
      conference_release({}, {:limit=>1,:order=>Momomoto.desc(:conference_release_id)})
    end

  end

  def self.log_content_columns
    columns.keys - [:conference_id]
  end

  def self.log_hidden_columns
    [:css]
  end

  def self.log_change_url( change )
    {:controller=>'pentabarf',:action=>:conference,:id=>change.conference_id}
  end

  def self.log_change_title( change )
    change.title
  end

end
