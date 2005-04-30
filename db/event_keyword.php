<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_keyword.
*/

class Event_Keyword extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "event_keyword";
    $this->order = "";
    $this->domain = "event";
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['not_null'] = true;
    $this->field['keyword_id']['type'] = 'INTEGER';
    $this->field['keyword_id']['not_null'] = true;
    $this->field['event_id']['primary_key'] = true;
    $this->field['keyword_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
