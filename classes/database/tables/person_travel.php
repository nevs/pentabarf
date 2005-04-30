<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_time.php');
require_once('../classes/database/datatypes/dt_date.php');
require_once('../classes/database/datatypes/dt_decimal.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table person_travel
class PERSON_TRAVEL extends DB_BASE
{
   /// constructor of the class person_travel
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person_travel';
      $this->domain = 'person_travel';
      $this->limit = 0;
      $this->order = '';

      $this->fields['travel_cost'] = new DT_DECIMAL( $this, 'travel_cost', array('scale' => 2, 'precision' => 16), array() );
      $this->fields['f_departure_pickup'] = new DT_BOOL( $this, 'f_departure_pickup', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['accommodation_phone'] = new DT_VARCHAR( $this, 'accommodation_phone', array('length' => 32), array() );
      $this->fields['arrival_to'] = new DT_VARCHAR( $this, 'arrival_to', array('length' => 64), array() );
      $this->fields['arrival_transport_id'] = new DT_INTEGER( $this, 'arrival_transport_id', array(), array() );
      $this->fields['departure_number'] = new DT_VARCHAR( $this, 'departure_number', array('length' => 32), array() );
      $this->fields['accommodation_city'] = new DT_VARCHAR( $this, 'accommodation_city', array('length' => 64), array() );
      $this->fields['accommodation_name'] = new DT_VARCHAR( $this, 'accommodation_name', array('length' => 64), array() );
      $this->fields['accommodation_currency_id'] = new DT_INTEGER( $this, 'accommodation_currency_id', array(), array('NOT_NULL' => true) );
      $this->fields['departure_time'] = new DT_TIME( $this, 'departure_time', array('precision' => 0), array() );
      $this->fields['accommodation_phone_room'] = new DT_VARCHAR( $this, 'accommodation_phone_room', array('length' => 32), array() );
      $this->fields['departure_date'] = new DT_DATE( $this, 'departure_date', array(), array() );
      $this->fields['accommodation_postcode'] = new DT_VARCHAR( $this, 'accommodation_postcode', array('length' => 10), array() );
      $this->fields['accommodation_cost'] = new DT_DECIMAL( $this, 'accommodation_cost', array('scale' => 2, 'precision' => 16), array() );
      $this->fields['travel_currency_id'] = new DT_INTEGER( $this, 'travel_currency_id', array(), array('NOT_NULL' => true) );
      $this->fields['arrival_time'] = new DT_TIME( $this, 'arrival_time', array('precision' => 0), array() );
      $this->fields['arrival_number'] = new DT_VARCHAR( $this, 'arrival_number', array('length' => 32), array() );
      $this->fields['conference_id'] = new DT_INTEGER( $this, 'conference_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['f_arrived'] = new DT_BOOL( $this, 'f_arrived', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['accommodation_street'] = new DT_VARCHAR( $this, 'accommodation_street', array('length' => 64), array() );
      $this->fields['f_arrival_pickup'] = new DT_BOOL( $this, 'f_arrival_pickup', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['arrival_date'] = new DT_DATE( $this, 'arrival_date', array(), array() );
      $this->fields['arrival_from'] = new DT_VARCHAR( $this, 'arrival_from', array('length' => 64), array() );
      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['departure_to'] = new DT_VARCHAR( $this, 'departure_to', array('length' => 64), array() );
      $this->fields['departure_from'] = new DT_VARCHAR( $this, 'departure_from', array('length' => 64), array() );
      $this->fields['departure_transport_id'] = new DT_INTEGER( $this, 'departure_transport_id', array(), array() );
   }

}

?>
