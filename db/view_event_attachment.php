<?php

require_once('view.php');

/**
 * Class for accessing, manipulating, creating and deleting records in event_attachment.
*/

class View_Event_Attachment extends View
{

  public function __construct($select = array())
  {
    $this->table = 'event_attachment, attachment_type';
    $this->order = '';
    $this->domain = 'event';
    $this->join = 'event_attachment.attachment_type_id = attachment_type.attachment_type_id';
    $this->field['event_attachment_id']['type'] = 'SERIAL';
    $this->field['event_attachment_id']['table'] = 'event_attachment';
    $this->field['event_attachment_id']['primary_key'] = true;
    $this->field['attachment_type_id']['type'] = 'INTEGER';
    $this->field['attachment_type_id']['table'] = 'event_attachment';
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['table'] = 'event_attachment';
    $this->field['mime_type_id']['type'] = 'INTEGER';
    $this->field['mime_type_id']['table'] = 'event_attachment';
    $this->field['filename']['type'] = 'VARCHAR';
    $this->field['filename']['table'] = 'event_attachment';
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['table'] = 'event_attachment';
    $this->field['f_public']['type'] = 'BOOL';
    $this->field['f_public']['table'] = 'event_attachment';
    $this->field['data']['type'] = 'BYTEA';
    $this->field['data']['table'] = 'event_attachment';
    $this->field['filesize']['type'] = 'INTEGER';
    $this->field['filesize']['name'] = 'octet_length(event_attachment.data)';
    $this->field['attachment_type_tag']['type'] = 'VARCHAR';
    $this->field['attachment_type_tag']['name'] = 'attachment_type.tag';
    parent::__construct($select);
  }

}

?>
