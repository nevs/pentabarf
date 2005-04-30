<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in conference_track_localized.
*/

class Conference_Track_Localized extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "conference_track_localized";
    $this->order = "";
    $this->domain = "localization";
    $this->field['conference_track_id']['type'] = 'INTEGER';
    $this->field['conference_track_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['length'] = 64;
    $this->field['name']['not_null'] = true;
    $this->field['conference_track_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
