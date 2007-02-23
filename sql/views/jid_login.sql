
CREATE OR REPLACE VIEW view_jid_login AS
  SELECT person_im_id,
         person_id,
         im_address,
         view_person.name,
         view_person.preferences
    FROM person_im
         INNER JOIN im_type USING (im_type_id)
         INNER JOIN view_person USING (person_id)
   WHERE im_type.tag = 'jabber';

