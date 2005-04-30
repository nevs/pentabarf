<?php

require_once("view_event_person.php");

/**
 * Class for accessing, manipulating, creating and deleting records in event_person.
*/

class View_Event_Person_with_Role extends View_Event_Person
{

  public function __construct($select = array())
  {
    $this->table = "event_person, event_role";
    $this->order = "";
    $this->domain = "event";
    $this->join = "event_person.event_role_id = event_role.event_role_id";

    $this->field['event_role_tag']['type'] = 'VARCHAR';
    $this->field['event_role_tag']['name'] = 'event_role.tag';
    parent::__construct($select);
  }

}

?>
