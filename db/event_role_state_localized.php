<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_role_state_localized.
*/

class Event_Role_State_Localized extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "event_role_state_localized";
    $this->order = "";
    $this->domain = "localization";
    $this->field['event_role_state_id']['type'] = 'INTEGER';
    $this->field['event_role_state_id']['not_null'] = true;
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['not_null'] = true;
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['length'] = 64;
    $this->field['name']['not_null'] = true;
    $this->field['event_role_state_id']['primary_key'] = true;
    $this->field['language_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
