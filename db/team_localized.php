<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in team_localized.
*/

class Team_Localized extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "team_localized";
    $this->order = "";
    $this->domain = "localization";
    $this->field['team_id']['type'] = 'INTEGER';
    $this->field['team_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['length'] = 64;
    $this->field['name']['not_null'] = true;
    $this->field['team_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
