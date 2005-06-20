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
    $this->table = "person_travel INNER JOIN view_person AS person USING (person_id)";
    $this->domain = "person";
    $this->order = "name";
    $this->join = "person_travel.f_arrival_pickup = 't' OR person_travel.f_departure_pickup = 't'";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['name']['type'] = 'TEXT';
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['type']['type'] = 'TEXT';
    $this->field['transport_id']['type'] = 'INTEGER';
    $this->field['transport']['type'] = 'TEXT';
    $this->field['from']['type'] = 'TEXT';
    $this->field['to']['type'] = 'TEXT';
    $this->field['number']['type'] = 'TEXT';
    $this->field['date']['type'] = 'DATE';
    $this->field['time']['type'] = 'TIME';
    $this->field['f_pickup']['type'] = 'BOOL';
    
    parent::__construct($select);
   
  }

  public function select( $where )
  {
    $this->clear();
    if ( count( $where ) < 1 || !isset( $where['conference_id'] ) || !( $conference_id = (integer) $where['conference_id'] ) ) {
      return 0;
    }
    $sql = "SELECT person_id, name, conference_id, 'Arrival' AS type, arrival_transport_id AS transport_id, transport.tag AS transport, arrival_from AS from, arrival_to AS to, arrival_number AS number, arrival_date AS date, arrival_time AS time, f_arrival_pickup AS f_pickup FROM person_travel INNER JOIN view_person USING (person_id) INNER JOIN transport ON (arrival_transport_id = transport.transport_id) WHERE conference_id = '{$conference_id}' AND f_arrival_pickup = 't' UNION SELECT person_id, name, conference_id, 'Departure' AS type, departure_transport_id AS transport_id, transport.tag AS transport, departure_from AS from, departure_to AS to, departure_number AS number, departure_date AS date, departure_time AS time, f_departure_pickup AS f_pickup FROM person_travel INNER JOIN view_person USING (person_id) INNER JOIN transport ON (departure_transport_id = transport.transport_id) WHERE conference_id = '{$conference_id}' AND f_departure_pickup = 't' ORDER BY date,time;";
    return $this->real_select($sql);
  }
}

?>
