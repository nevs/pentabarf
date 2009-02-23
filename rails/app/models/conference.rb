class Conference < Momomoto::Table
  default_order( Momomoto.lower(:acronym) )

  module Methods

    def days( conditions = {}, options = {} )
      Conference_day.select( conditions.merge( {:conference_id=>conference_id} ), options )
    end

    def rooms( conditions = {}, options = {} )
      Conference_room.select( conditions.merge( {:conference_id=>conference_id} ), options )
    end

    def tracks( conditions = {}, options = {} )
      Conference_track.select( conditions.merge( {:conference_id=>conference_id} ), options )
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
