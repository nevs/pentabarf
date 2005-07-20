<?php

require_once("view.php");

/**
* Class for accessing, manipulating, creating and deleting records in event_person.
*/

class View_Email extends View
{
  public function __construct($select = array())
  {
    $this->distinct = "";
    $this->table = "view_person INNER JOIN event_person USING (person_id) INNER JOIN event USING (event_id) INNER JOIN event_state USING (event_state_id)";
    $this->domain = "person";
    $this->order = "name";
    $this->join = "";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['name']['type'] = 'TEXT';
    $this->field['email_contact']['type'] = 'TEXT';
    
    parent::__construct($select);
   
  }

  public function select( $where )
  {
    $this->clear();
    if ( count( $where ) < 1 || !isset( $where['conference_id'] ) || !( $conference_id = (integer) $where['conference_id'] ) ) {
      return 0;
    }
    $sql = "SELECT person_id, name, email_contact FROM view_person INNER JOIN event_person USING (person_id) INNER JOIN event USING (event_id) INNER JOIN event_role USING (event_role_id) INNER JOIN event_role_state USING (event_role_state_id) INNER JOIN event_state USING (event_state_id) WHERE event_state.tag = 'confirmed' AND event_role_state.tag = 'confirmed' AND event_role.tag IN ('speaker', 'moderator') AND view_person.email_contact IS NOT NULL AND event.conference_id = {$conference_id} ORDER BY email_contact;";
    return $this->real_select($sql);
  }
}

?>
