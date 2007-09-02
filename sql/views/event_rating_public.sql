
CREATE OR REPLACE VIEW view_event_rating_public AS
  SELECT event_rating_public.event_id,
         event.conference_id,
         event_rating_public.participant_knowledge,
         event_rating_public.topic_importance,
         event_rating_public.content_quality,
         event_rating_public.presentation_quality,
         event_rating_public.audience_involvement,
         event_rating_public.remark,
         event_rating_public.eval_time,
         event_rating_public.rater_ip
    FROM event_rating_public
         INNER JOIN event USING (event_id)
;

