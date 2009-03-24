
CREATE TRIGGER related_event_after_insert AFTER INSERT ON event_related FOR STATEMENT EXECUTE PROCEDURE event_related_trigger_insert();

CREATE TRIGGER related_event_after_delete AFTER DELETE ON event_related FOR STATEMENT EXECUTE PROCEDURE event_related_trigger_delete();

CREATE TRIGGER conference_release_after_insert AFTER INSERT ON conference_release FOR EACH ROW EXECUTE PROCEDURE conference_release_trigger_insert();

CREATE TRIGGER custom_fields_trigger BEFORE INSERT OR UPDATE OR DELETE ON custom.custom_fields FOR EACH ROW EXECUTE PROCEDURE custom_field_trigger();

