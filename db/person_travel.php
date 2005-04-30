<?php

require_once("entity.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_travel.
*/

class Person_Travel extends Entity
{

  public function __construct($select = array())
  {
    $this->table = "person_travel";
    $this->order = "";
    $this->domain = "person";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['not_null'] = true;
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['not_null'] = true;
    $this->field['arrival_transport_id']['type'] = 'INTEGER';
    $this->field['arrival_from']['type'] = 'VARCHAR';
    $this->field['arrival_from']['length'] = 64;
    $this->field['arrival_to']['type'] = 'VARCHAR';
    $this->field['arrival_to']['length'] = 64;
    $this->field['arrival_number']['type'] = 'VARCHAR';
    $this->field['arrival_number']['length'] = 32;
    $this->field['arrival_date']['type'] = 'DATE';
    $this->field['arrival_time']['type'] = 'TIME';
    $this->field['f_arrival_pickup']['type'] = 'BOOL';
    $this->field['f_arrival_pickup']['not_null'] = true;
    $this->field['f_arrival_pickup']['default'] = true;
    $this->field['f_departure_pickup']['type'] = 'BOOL';
    $this->field['f_departure_pickup']['not_null'] = true;
    $this->field['f_departure_pickup']['default'] = true;
    $this->field['departure_transport_id']['type'] = 'INTEGER';
    $this->field['departure_from']['type'] = 'VARCHAR';
    $this->field['departure_from']['length'] = 64;
    $this->field['departure_to']['type'] = 'VARCHAR';
    $this->field['departure_to']['length'] = 64;
    $this->field['departure_number']['type'] = 'VARCHAR';
    $this->field['departure_number']['length'] = 32;
    $this->field['departure_date']['type'] = 'DATE';
    $this->field['departure_time']['type'] = 'TIME';
    $this->field['travel_cost']['type'] = 'DECIMAL';
    $this->field['travel_cost']['length'] = 16;
    $this->field['travel_cost']['fraction'] = 2;
    $this->field['travel_currency_id']['type'] = 'INTEGER';
    $this->field['travel_currency_id']['not_null'] = true;
    $this->field['accommodation_cost']['type'] = 'DECIMAL';
    $this->field['accommodation_cost']['length'] = 16;
    $this->field['accommodation_cost']['fraction'] = 2;
    $this->field['accommodation_currency_id']['type'] = 'INTEGER';
    $this->field['accommodation_currency_id']['not_null'] = true;
    $this->field['accommodation_name']['type'] = 'VARCHAR';
    $this->field['accommodation_name']['length'] = 64;
    $this->field['accommodation_street']['type'] = 'VARCHAR';
    $this->field['accommodation_street']['length'] = 64;
    $this->field['accommodation_postcode']['type'] = 'VARCHAR';
    $this->field['accommodation_postcode']['length'] = 10;
    $this->field['accommodation_city']['type'] = 'VARCHAR';
    $this->field['accommodation_city']['length'] = 64;
    $this->field['accommodation_phone']['type'] = 'VARCHAR';
    $this->field['accommodation_phone']['length'] = 32;
    $this->field['accommodation_phone_room']['type'] = 'VARCHAR';
    $this->field['accommodation_phone_room']['length'] = 32;
    $this->field['f_arrived']['type'] = 'BOOL';
    $this->field['f_arrived']['not_null'] = true;
    $this->field['f_arrived']['default'] = true;
    $this->field['person_id']['primary_key'] = true;
    $this->field['conference_id']['primary_key'] = true;
    parent::__construct($select);
  }

}

?>
