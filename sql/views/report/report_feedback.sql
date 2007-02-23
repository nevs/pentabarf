
CREATE OR REPLACE VIEW view_report_feedback AS
  SELECT event_id,
         conference_id,
         title,
         subtitle,
         count(event_id) AS votes,
         count(event_rating_public.remark) AS comments,
         sum(4 * coalesce(participant_knowledge,0))/(CASE count(participant_knowledge) WHEN 0 THEN 1 ELSE count(participant_knowledge) END) AS participant_knowledge,
         sum(4 * coalesce(topic_importance,0))/(CASE count(topic_importance) WHEN 0 THEN 1 ELSE count(topic_importance) END) AS topic_importance,
         sum(4 * coalesce(content_quality,0))/(CASE count(content_quality) WHEN 0 THEN 1 ELSE count(content_quality) END) AS content_quality,
         sum(4 * coalesce(presentation_quality,0))/(CASE count(presentation_quality) WHEN 0 THEN 1 ELSE count(presentation_quality) END) AS presentation_quality,
         sum(4 * coalesce(audience_involvement,0))/(CASE count(audience_involvement) WHEN 0 THEN 1 ELSE count(audience_involvement) END) AS audience_involvement
    FROM event_rating_public
         INNER JOIN event USING (event_id)
   GROUP BY event_id, conference_id, title, subtitle
;

