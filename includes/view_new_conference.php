<?php

  require_once('../db/conference.php');
  require_once('../db/conference_track.php');
  require_once('../db/country_localized.php');
  require_once('../db/time_zone.php');
  require_once('../db/time_zone_localized.php');
  require_once('../db/currency.php');
  require_once('../db/language_localized.php');
  require_once('../db/person.php');
  require_once('../functions/tabs.php');
  require_once('../functions/fill_select.php');
  require_once('../includes/common-conference.php');

  $template->readTemplatesFromFile('view_conference.tmpl');

  // array with the names of the js-switched tabs
  $tab_names = array('general', 'persons', 'tracks', 'rooms');

  content_tabs($tab_names, $template);

  $conference = new Conference;
 
  if ( $conference->check_authorisation( 'create_conference' ) !== true ) {
    throw new Privilege_Exception("Not allowed to create new conferences.");
  }

  $template->addVar('main','CONTENT_TITLE','New Conference');
  $template->addVar('main','VIEW_TITLE','New Conference');
  $template->addVar('content', 'IMAGE_URL', get_conference_image_url(0, '64x64'));
  $template->setAttribute('register_handler', 'visibility', 'visible');
  

  for ($i = 1; $i < 24; $i++){
    $days[$i-1] = array(  
        'VALUE'     => $i,
        'TEXT'      => $i,
    );
  }
  $template->addRows('days',$days);
 
  $max_timeslot = array();
  array_push($max_timeslot, array('VALUE' => "", 'SELECTED' => "selected='selected'"));
  for ($i = 1; $i < 21; $i++){
    array_push($max_timeslot, array('VALUE' => $i, 'TEXT' => $i));
  }
  $template->addRows("max_timeslot_duration", $max_timeslot);

  $country = new Country_Localized;
  $country->select(array("language_id" => $preferences['language']));
  fill_select("country", $country, "country_id", "name", 0);

  $time_zone = new Time_Zone;
  $time_zone_localized = new Time_Zone_Localized;
  $time_zone->select();
  $time_zones[0] = array('VALUE' => 0,'TEXT' =>"");
  foreach($time_zone as $key) {
    $time_zone_localized->select(array("time_zone_id" => $time_zone->get("time_zone_id"),"language_id" => $preferences['language']));
    $time_zones[$key] = array('VALUE' => $time_zone->get("time_zone_id"), 'TEXT' => $time_zone_localized->get("name"));
  }
  $template->addRows("time_zone",$time_zones);
  
  $currency = new Currency;
  $currency->select(array("f_visible" => "t"));
  fill_select("currency", $currency, "currency_id", "iso_4217_code", 0);

  $language = new Language_Localized;
  $language->select();
  fill_select("primary_language", $language, "translated_id", "name", 0);
  fill_select("secondary_language", $language, "translated_id", "name", 0);

  for ($i = 1; $i < 25; $i++){
    $value = "0".((integer)(($i * 5)/60)).":".($i%12 < 2 ? "0" : "").(($i * 5)%60).":00";
    $timeslot_duration[$i-1] = array(
        'VALUE'     => $value,
        'TEXT'      => ($i * 5)." min",
    );
  }
  $template->addRows('timeslot_duration',$timeslot_duration);

  for ($i = 0; $i < 24; $i++) {
    $value = !$i ? "00" : ($i < 10 ? "0".$i :$i);
    $value .= ":00";
    $day_change[$i] = array( 'VALUE' => $value.":00", 'TEXT' => $value );
  }
  $template->addRows('day_change',$day_change);

?>
