
CREATE OR REPLACE FUNCTION copy_event( source_event_id INTEGER, target_conference_id INTEGER, coordinator_id INTEGER ) RETURNS INTEGER AS $$
  DECLARE
    target_event_id INTEGER;
    source_conference_id INTEGER;

  BEGIN
    SELECT INTO target_event_id nextval('base.event_event_id_seq');
    SELECT INTO source_conference_id conference_id FROM event WHERE event_id = source_event_id;

    INSERT INTO 
      event(
        event_id,
        conference_id,
        slug,
        title,
        subtitle,
        conference_track_id,
        event_type,
        duration,
        event_origin,
        event_state,
        event_state_progress,
        language,
        abstract,
        description,
        resources,
        public,
        paper,
        slides,
        remark,
        submission_notes
      )
    SELECT
      target_event_id,
      target_conference_id,
      slug,
      title,
      subtitle,
      (CASE target_conference_id WHEN source_conference_id THEN conference_track_id ELSE NULL END),
      event_type,
      duration,
      'idea',
      'undecided',
      'new',
      language,
      abstract,
      description,
      resources,
      public,
      paper,
      slides,
      remark,
      submission_notes
    FROM event WHERE event_id = source_event_id;

    INSERT INTO event_image( event_id, mime_type, image ) 
      SELECT target_event_id, mime_type, image FROM event_image 
        WHERE event_id = source_event_id;

    -- copy all public event roles
    INSERT INTO event_person( event_id, person_id, event_role, event_role_state, remark )
      SELECT target_event_id, person_id, event_role, 'idea', remark FROM event_person INNER JOIN event_role USING (event_role)
        WHERE
          event_role.public = true AND
          event_person.event_id = source_event_id;

    -- create coordinator
    INSERT INTO event_person( event_id, person_id, event_role )
      VALUES (target_event_id, coordinator_id, 'coordinator');

    INSERT INTO event_link( event_id, url, title, rank )
      SELECT target_event_id, url, title, rank FROM event_link 
        WHERE event_id = source_event_id;

    RETURN target_event_id;
  END;
$$ LANGUAGE plpgsql;


