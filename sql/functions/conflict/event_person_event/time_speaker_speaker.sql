-- Check for time conflicts between speakers

CREATE OR REPLACE FUNCTION conflict.conflict_event_person_event_time_speaker_speaker(integer) RETURNS SETOF conflict.conflict_event_person_event AS $$
  SELECT
    ep1.person_id AS person_id,
    ep1.event_id AS event_id1,
    ep2.event_id AS event_id2
  FROM
    event_person AS ep1
    INNER JOIN event AS e1 ON (
      e1.conference_id = $1 AND
      e1.event_id = ep1.event_id AND
      e1.start_time IS NOT NULL AND
      e1.event_state = 'accepted' AND
      e1.event_state_progress <> 'canceled'
    )
    INNER JOIN conference_day AS cd1 USING (conference_day_id)
    INNER JOIN event_person AS ep2 ON (
      ep2.person_id = ep1.person_id AND
      ep2.event_role IN ('speaker','moderator') AND
      ep2.event_role_state = 'confirmed' AND
      ep2.event_id <> ep1.event_id
    )
    INNER JOIN event AS e2 ON (
      e2.conference_id = $1 AND
      e2.event_id = ep2.event_id AND
      e2.start_time IS NOT NULL AND
      e2.event_state = 'accepted' AND
      e2.event_state_progress <> 'canceled'
    )
    INNER JOIN conference_day AS cd2 ON (
      cd2.conference_day_id = e2.conference_day_id
    )
  WHERE
    ep1.event_role IN ('speaker','moderator') AND
    ep1.event_role_state = 'confirmed' AND
    (cd1.conference_day + e1.start_time, e1.duration) OVERLAPS (cd2.conference_day + e2.start_time, e2.duration) AND
    -- OVERLAPS also returns true when the end of interval 1 matches the start of interval 2
    -- thats why we exclude those cases explicitly
    cd1.conference_day + e1.start_time + e1.duration <> cd2.conference_day + e2.start_time AND
    cd2.conference_day + e2.start_time + e2.duration <> cd1.conference_day + e1.start_time;

$$ LANGUAGE SQL RETURNS NULL ON NULL INPUT;

