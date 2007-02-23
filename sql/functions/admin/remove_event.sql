
CREATE OR REPLACE FUNCTION remove_event( event_id INTEGER ) RETURNS INTEGER AS $$
  DECLARE
  BEGIN
    DELETE FROM event_transaction WHERE event_transaction.event_id = event_id;
    DELETE FROM event_related WHERE event_related.event_id1 = event_id;
    DELETE FROM event_image WHERE event_image.event_id = event_id;
    DELETE FROM event_person WHERE event_person.event_id = event_id;
    DELETE FROM event_link WHERE event_link.event_id = event_id;
    DELETE FROM event_link_internal WHERE event_link_internal.event_id = event_id;
    DELETE FROM event_attachment WHERE event_attachment.event_id = event_id;
    DELETE FROM event_rating WHERE event_rating.event_id = event_id;
    DELETE FROM event_rating_public WHERE event_rating_public.event_id = event_id;
    DELETE FROM event WHERE event.event_id = event_id;
    RETURN event_id;
  END;
$$ LANGUAGE PLPGSQL RETURNS NULL ON NULL INPUT;

