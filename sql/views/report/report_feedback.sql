
CREATE OR REPLACE VIEW view_report_feedback AS
  SELECT
    event_id,
    conference_id,
    title,
    subtitle,
    conference_track,
    speaker_ids,
    speakers,
    votes,
    comments,
    (f1_average*f1_votes/(f1_votes+minimum) + f1_total_average*minimum/(f1_votes+minimum)) AS participant_knowledge,
    (f2_average*f2_votes/(f2_votes+minimum) + f2_total_average*minimum/(f2_votes+minimum)) AS topic_importance,
    (f3_average*f3_votes/(f3_votes+minimum) + f3_total_average*minimum/(f3_votes+minimum)) AS content_quality,
    (f4_average*f4_votes/(f4_votes+minimum) + f4_total_average*minimum/(f4_votes+minimum)) AS presentation_quality,
    (f5_average*f5_votes/(f5_votes+minimum) + f5_total_average*minimum/(f5_votes+minimum)) AS audience_involvement
  FROM (
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
      coalesce( sum((participant_knowledge - 3) * 50 )/ count(participant_knowledge), 0) AS f1_average,
      count(participant_knowledge) AS f1_votes,
      ( SELECT coalesce( sum((participant_knowledge - 3) * 50 )/ count(participant_knowledge), 0)
        FROM event_feedback INNER JOIN event AS inner_event USING(event_id)
        WHERE inner_event.conference_id = event.conference_id ) AS f1_total_average,
      coalesce( sum((topic_importance - 3) * 50 )/ count(topic_importance), 0) AS f2_average,
      count(topic_importance) AS f2_votes,
      ( SELECT coalesce( sum((topic_importance - 3) * 50 )/ count(topic_importance), 0)
        FROM event_feedback INNER JOIN event AS inner_event USING(event_id)
        WHERE inner_event.conference_id = event.conference_id ) AS f2_total_average,
      coalesce( sum((content_quality - 3) * 50 )/ count(content_quality), 0) AS f3_average,
      count(content_quality) AS f3_votes,
      ( SELECT coalesce( sum((content_quality - 3) * 50 )/ count(content_quality), 0)
        FROM event_feedback INNER JOIN event AS inner_event USING(event_id)
        WHERE inner_event.conference_id = event.conference_id ) AS f3_total_average,
      coalesce( sum((presentation_quality - 3) * 50 )/ count(presentation_quality), 0) AS f4_average,
      count(presentation_quality) AS f4_votes,
      ( SELECT coalesce( sum((presentation_quality - 3) * 50 )/ count(presentation_quality), 0)
        FROM event_feedback INNER JOIN event AS inner_event USING(event_id)
        WHERE inner_event.conference_id = event.conference_id ) AS f4_total_average,
      coalesce( sum((audience_involvement - 3) * 50 )/ count(audience_involvement), 0) AS f5_average,
      count(audience_involvement) AS f5_votes,
      ( SELECT coalesce( sum((audience_involvement - 3) * 50 )/ count(audience_involvement), 0)
        FROM event_feedback INNER JOIN event AS inner_event USING(event_id)
        WHERE inner_event.conference_id = event.conference_id ) AS f5_total_average,
      10 AS minimum
    FROM event_feedback
      INNER JOIN event USING (event_id)
    GROUP BY event_id, conference_id, title, subtitle, conference_track, speaker_ids, speakers
  ) AS t1
;

