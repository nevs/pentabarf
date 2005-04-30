<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_attachment.
*/

class Event_Attachment extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "event_attachment";
    $this->order = "";
    $this->domain = "event";
    $this->field['event_attachment_id']['type'] = 'SERIAL';
    $this->field['event_attachment_id']['not_null'] = true;
    $this->field['attachment_type_id']['type'] = 'INTEGER';
    $this->field['attachment_type_id']['not_null'] = true;
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['not_null'] = true;
    $this->field['mime_type_id']['type'] = 'INTEGER';
    $this->field['mime_type_id']['not_null'] = true;
    $this->field['filename']['type'] = 'VARCHAR';
    $this->field['filename']['length'] = 256;
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['length'] = 64;
    $this->field['data']['type'] = 'BYTEA';
    $this->field['data']['not_null'] = true;
    $this->field['f_public']['type'] = 'BOOL';
    $this->field['f_public']['not_null'] = true;
    $this->field['f_public']['default'] = true;
    $this->field['event_attachment_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
