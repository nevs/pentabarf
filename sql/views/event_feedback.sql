
CREATE OR REPLACE VIEW view_event_feedback AS
  SELECT event_feedback.event_id,
         event.conference_id,
         event_feedback.participant_knowledge,
         event_feedback.topic_importance,
         event_feedback.content_quality,
         event_feedback.presentation_quality,
         event_feedback.audience_involvement,
         event_feedback.remark,
         event_feedback.eval_time
    FROM event_feedback
         INNER JOIN event USING (event_id)
;

