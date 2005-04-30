<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_role_localized.
*/

class Event_Role_Localized extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "event_role_localized";
    $this->order = "";
    $this->domain = "localization";
    $this->field['event_role_id']['type'] = 'INTEGER';
    $this->field['event_role_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['length'] = 64;
    $this->field['event_role_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
