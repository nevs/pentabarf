
CREATE OR REPLACE VIEW view_event_feedback_statistics AS
  SELECT event.event_id,
         round(sum((participant_knowledge-3)*50::numeric)/count(participant_knowledge), -1) AS participant_knowledge,
         count(participant_knowledge) AS participant_knowledge_count,
         round(sum((topic_importance-3)*50::numeric)/count(topic_importance), -1) AS topic_importance,
         count(topic_importance) AS topic_importance_count,
         round(sum((content_quality-3)*50::numeric)/count(content_quality), -1) AS content_quality,
         count(content_quality) AS content_quality_count,
         round(sum((presentation_quality-3)*50::numeric)/count(presentation_quality), -1) AS presentation_quality,
         count(presentation_quality) AS presentation_quality_count,
         round(sum((audience_involvement-3)*50::numeric)/count(audience_involvement), -1) AS audience_involvement,
         count(audience_involvement) AS audience_involvement_count
    FROM event
         LEFT OUTER JOIN event_feedback USING (event_id)
   GROUP BY event.event_id
;

