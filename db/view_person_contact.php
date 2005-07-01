<?php

require_once("view.php");

/**
* Class for accessing, manipulating, creating and deleting records in event_person.
*/

class View_Person_Travel extends View
{
  public function __construct($select = array())
  {
    $this->distinct = "";
    $this->table = "view_person INNER JOIN event_person USING (person_id) INNER JOIN event USING (event_id) INNER JOIN event_state USING (event_state_id)";
    $this->domain = "person";
    $this->order = "name";
    $this->join = "";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['table'] = 'view_person';
    $this->field['name']['type'] = 'TEXT';
    $this->field['name']['table'] = 'view_person';
    $this->field['states']['type'] = 'TEXT';
    $this->field['email_contact']['type'] = 'TEXT';
    $this->field['email_contact']['table'] = 'view_person';
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['table'] = 'event';
    $this->field['telephone']['type'] = 'TEXT';
    $this->field['telephone']['name'] = "person_phone_by_type(view_person.person_id, 'phone')";
    $this->field['mobile']['type'] = 'TEXT';
    $this->field['mobile']['name'] = "person_phone_by_type(view_person.person_id, 'mobile')";
    $this->field['dect']['type'] = 'TEXT';
    $this->field['dect']['name'] = "person_phone_by_type(view_person.person_id, 'dect')";
    
    parent::__construct($select);
   
  }

  public function select( $where )
  {
    $this->clear();
    if ( count( $where ) < 1 || !isset( $where['conference_id'] ) || !( $conference_id = (integer) $where['conference_id'] ) ) {
      return 0;
    }
    $sql = "SELECT person_id, name, person_event_role_states(person_id,{$conference_id}) AS states, email_contact, person_phone_by_type(view_person.person_id, 'phone') AS telephone, person_phone_by_type(view_person.person_id, 'mobile') AS mobile, person_phone_by_type(view_person.person_id, 'dect') AS dect FROM view_person WHERE EXISTS (SELECT 1 FROM event_person INNER JOIN event USING (event_id) INNER JOIN event_state USING (event_state_id) INNER JOIN event_role_state USING (event_role_state_id) where person_id = view_person.person_id AND conference_id = {$conference_id} ) ORDER BY name";
    return $this->real_select($sql);
  }
}

?>
