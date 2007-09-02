
-- trigger for ensuring that there are always pairs of linked events
CREATE OR REPLACE FUNCTION event_related_trigger_insert() RETURNS TRIGGER AS $$
   DECLARE
      cur_record RECORD;

   BEGIN

      FOR cur_record IN
         SELECT event_id1, event_id2 FROM event_related
            WHERE NOT EXISTS (SELECT event_id1, event_id2 FROM event_related AS related WHERE event_related.event_id1 = related.event_id2 AND event_related.event_id2 = related.event_id1)
      LOOP
        INSERT INTO event_related (event_id1, event_id2) VALUES (cur_record.event_id2, cur_record.event_id1);
      END LOOP;

      RETURN NEW;
   END;
$$ LANGUAGE 'plpgsql';


-- trigger for ensuring that there are always pairs of linked events
CREATE OR REPLACE FUNCTION event_related_trigger_delete() RETURNS TRIGGER AS $$
   DECLARE
      cur_record RECORD;

   BEGIN

      FOR cur_record IN
         SELECT event_id1, event_id2 FROM event_related
            WHERE NOT EXISTS (SELECT event_id1, event_id2 FROM event_related AS related WHERE event_related.event_id1 = related.event_id2 AND event_related.event_id2 = related.event_id1)
      LOOP
         DELETE FROM event_related WHERE event_id1 = cur_record.event_id1 AND event_id2 = cur_record.event_id2;
      END LOOP;
      RETURN NULL;
   END;
$$ LANGUAGE 'plpgsql';

