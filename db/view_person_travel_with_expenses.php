<?php

require_once("view.php");

/**
 * Class for accessing, manipulating, creating and deleting records in person_travel.
*/

class View_Person_Travel_with_Expenses extends View
{

  public function __construct($select = array())
  {
    $this->table = "person_travel, currency AS c_acco, currency AS c_travel";
    $this->order = "";
    $this->domain = "person";
    $this->join = "c_acco.currency_id = person_travel.accommodation_currency_id AND c_travel.currency_id = person_travel.travel_currency_id AND (person_travel.accommodation_cost IS NOT NULL OR person_travel.travel_cost IS NOT NULL)";
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['table'] = 'person_travel';
    $this->field['conference_id']['type'] = 'INTEGER';
    $this->field['conference_id']['table'] = 'person_travel';
    $this->field['travel_cost']['type'] = 'DECIMAL';
    $this->field['travel_cost']['name'] = 'person_travel.travel_cost / c_travel.exchange_rate';
    $this->field['accommodation_cost']['type'] = 'DECIMAL';
    $this->field['accommodation_cost']['name'] = 'person_travel.accommodation_cost /c_acco.exchange_rate';
    parent::__construct($select);
  }
  
  public function get_expenses_sum($conference_id)
  {
    $conference_id = $this->check_integer($conference_id);
    return $this->select_single("sum", "SELECT sum( coalesce(p.travel_cost, 0) / c_travel.exchange_rate)+ sum( coalesce( p.accommodation_cost, 0 ) / c_acco.exchange_rate) AS sum from person_travel AS p,currency AS c_travel, currency AS c_acco WHERE (p.travel_cost is not null OR p.accommodation_cost IS NOT NULL) AND c_travel.currency_id = p.travel_currency_id AND c_acco.currency_id = p.accommodation_currency_id AND p.conference_id = $conference_id;");
  }

}

?>
