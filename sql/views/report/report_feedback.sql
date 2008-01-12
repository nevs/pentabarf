
CREATE OR REPLACE VIEW view_report_feedback AS
  SELECT 
    event_id,
    conference_id,
    title,
    subtitle,
    conference_track,
    array_to_string(ARRAY(
      SELECT view_person.person_id
        FROM
          event_person
          INNER JOIN view_person USING (person_id)
        WHERE
          event_person.event_role IN ('speaker','moderator') AND
          event_person.event_role_state = 'confirmed' AND
          event_person.event_id = event.event_id
        ORDER BY view_person.name, event_person.person_id
      ), E'\n'::text) AS speaker_ids,
    array_to_string(ARRAY(
      SELECT view_person.name
        FROM
          event_person
          INNER JOIN view_person USING (person_id)
        WHERE
          event_person.event_role IN ('speaker','moderator') AND
          event_person.event_role_state = 'confirmed' AND
          event_person.event_id = event.event_id
        ORDER BY view_person.name, event_person.person_id
    ), E'\n'::text) AS speakers,
    count(event_id) AS votes,
    count(event_feedback.remark) AS comments,
    coalesce( sum((participant_knowledge - 3) * 50 )/ count(participant_knowledge), 0) AS participant_knowledge,
    coalesce( sum((topic_importance - 3) * 50 )/ count(topic_importance), 0) AS topic_importance,
    coalesce( sum((content_quality - 3) * 50 )/ count(content_quality), 0) AS content_quality,
    coalesce( sum((presentation_quality - 3) * 50 )/ count(presentation_quality), 0) AS presentation_quality,
    coalesce( sum((audience_involvement - 3) * 50 )/ count(audience_involvement), 0) AS audience_involvement
  FROM event_feedback
    INNER JOIN event USING (event_id)
  GROUP BY event_id, conference_id, title, subtitle, conference_track, speaker_ids, speakers
;

