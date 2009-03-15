class Release::Event < Momomoto::Table

  schema_name 'release'

  module Methods

    def attachments
      Release::Event_attachment.select({:event_id=>event_id,:conference_release_id=>conference_release_id,:public=>'t'})
    end

  end

end
