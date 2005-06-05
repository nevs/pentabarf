<?php

  require_once("../db/view_person.php");
  require_once("../db/view_person_travel_with_expenses.php");
  require_once("../db/currency.php");


  $template->addVar("main","CONTENT_TITLE","Reports: Expenses");
  $template->addVar("main","VIEW_TITLE", "Reports");


  $p_t = new View_Person_Travel_with_Expenses;
  $p_t->select(array('conference_id' => $preferences['conference']));

  $result = array();
  $currency = new Currency;
  $currency->select(array('f_default' => 't'));
  $curr_sign = $currency->get('iso_4217_code');

  $person = new View_Person;
  
  $sum_travel_cost = 0;
  $sum_accommodation_cost = 0;
  $sum_fee         = 0;
  
  foreach($p_t as $value) {
    $person->select(array('person_id' => $p_t->get('person_id')));
    
    $sum_travel_cost += $p_t->get('travel_cost');
    $sum_accommodation_cost += $p_t->get('accommodation_cost');
    $sum_fee += $p_t->get('fee');
    
    array_push($result, array("IMAGE_URL"          => get_person_image_url($person),
                              "URL"                => get_person_url($person, "#travel"),
                              "NAME"               => $person->get('name'),
                              "TRAVEL_COST"        => $p_t->get('travel_cost') ? sprintf("%.2f",round($p_t->get('travel_cost'),2))." $curr_sign" : "",
                              "ACCOMMODATION_COST" => $p_t->get('accommodation_cost') ? sprintf("%.2f",round($p_t->get('accommodation_cost'),2))." $curr_sign" : "",
                              "FEE"                => $p_t->get('fee') ? sprintf("%.2f",round($p_t->get('fee'),2))." $curr_sign" : "",
                              "SUM"                => $p_t->get('fee') || $p_t->get('travel_cost') || $p_t->get('accommodation_cost') ? sprintf("%.2f",round($p_t->get('fee') + $p_t->get('travel_cost') + $p_t->get('accommodation_cost'),2))." $curr_sign" : "" ));
  }
  $template->addRows("report-list", $result);


  $template->addVar("report-table", "TOTAL_SUM", sprintf("%.2f",round($p_t->get_expenses_sum($preferences['conference']),2))." ".$curr_sign);
  $template->addVar("report-table", "SUM_TRAVEL_COST", sprintf("%.2f",round($sum_travel_cost,2))." ".$curr_sign);
  $template->addVar("report-table", "SUM_ACCOMMODATION_COST", sprintf("%.2f",round($sum_accommodation_cost,2))." ".$curr_sign);
  $template->addVar("report-table", "SUM_FEE", sprintf("%.2f",round($sum_fee,2))." ".$curr_sign);


?>
