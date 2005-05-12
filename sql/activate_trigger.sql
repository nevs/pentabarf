
CREATE TRIGGER related_event_after_insert AFTER INSERT ON event_related FOR STATEMENT EXECUTE PROCEDURE event_related_trigger_insert();

CREATE TRIGGER related_event_after_delete AFTER DELETE ON event_related FOR STATEMENT EXECUTE PROCEDURE event_related_trigger_delete();

