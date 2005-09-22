-- copy abstract, description, remark and email_public into the conference-specific table for speaker and moderator
INSERT INTO conference_person( conference_id, 
                               person_id, 
                               abstract, 
                               description, 
                               remark, 
                               email_public) 
  SELECT DISTINCT ON (conference_id, person_id) 
         event.conference_id, 
         person.person_id, 
         person.abstract, 
         person.description, 
         person.remark, 
         person.email_public 
    FROM event_person 
         INNER JOIN event USING(event_id) 
         INNER JOIN person USING(person_id) 
         INNER JOIN event_role USING(event_role_id) 
   WHERE event_role.tag IN ('speaker', 'moderator');

-- move language out of table conference into table conference_language
INSERT INTO conference_language(conference_id, 
                                language_id, 
                                rank) 
  SELECT conference_id, 
         primary_language_id, 
         1 
    FROM conference 
   WHERE primary_language_id IS NOT NULL;

INSERT INTO conference_language(conference_id, 
                                language_id, 
                                rank) 
  SELECT conference_id, 
         secondary_language_id, 
         2 
    FROM conference 
   WHERE secondary_language_id IS NOT NULL;

