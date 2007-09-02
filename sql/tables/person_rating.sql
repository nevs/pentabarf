
CREATE TABLE person_rating (
  person_id INTEGER NOT NULL,
  evaluator_id INTEGER NOT NULL,
  speaker_quality SMALLINT CHECK (speaker_quality > 0 AND speaker_quality < 6),
  competence SMALLINT CHECK (competence > 0 AND competence < 6),
  remark TEXT,
  eval_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  FOREIGN KEY (person_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (evaluator_id) REFERENCES person (person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (person_id, evaluator_id)
) WITHOUT OIDS;

