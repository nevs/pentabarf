<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in conference_track.
*/

class Conference_Track extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "conference_track";
    $this->order = "";
    $this->domain = "conference";
    $this->field['conference_track_id']['type'] = 'SERIAL';
    $this->field['conference_track_id']['not_null'] = true;
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['tag']['not_null'] = true;
    $this->field['conference_track_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
