<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in team.
*/

class Team extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "team";
    $this->order = "";
    $this->domain = "conference";
    $this->field['team_id']['type'] = 'SERIAL';
    $this->field['team_id']['not_null'] = true;
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['length'] = 32;
    $this->field['tag']['not_null'] = true;
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['not_null'] = true;
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['team_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
