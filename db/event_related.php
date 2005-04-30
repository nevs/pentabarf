<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_related.
*/

class event_related extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "event_related";
    $this->order = "";
    $this->domain = "event";

    $this->field['event_id1']['type'] = 'INTEGER';
    $this->field['event_id1']['not_null'] = true;
    $this->field['event_id2']['type'] = 'INTEGER';
    $this->field['event_id2']['not_null'] = true;
    $this->field['event_id1']['primary_key'] = true;
    $this->field['event_id2']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
