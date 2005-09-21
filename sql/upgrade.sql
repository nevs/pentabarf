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
