
CREATE TABLE base.event_feedback (
  event_feedback_id SERIAL NOT NULL,
  event_id INTEGER NOT NULL,
  participant_knowledge SMALLINT CHECK (participant_knowledge > 0 AND participant_knowledge < 6),
  topic_importance SMALLINT CHECK (topic_importance > 0 AND topic_importance < 6),
  content_quality SMALLINT CHECK (content_quality > 0 AND content_quality < 6),
  presentation_quality SMALLINT CHECK (presentation_quality > 0 AND presentation_quality < 6),
  audience_involvement SMALLINT CHECK (audience_involvement > 0 AND audience_involvement < 6),
  remark TEXT,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE event_feedback (
  FOREIGN KEY (event_id) REFERENCES event (event_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (event_feedback_id)
) INHERITS( base.event_feedback );

CREATE TABLE log.event_feedback (
) INHERITS( base.logging, base.event_feedback );

