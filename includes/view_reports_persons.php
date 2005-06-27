<?php

  require_once("../db/person.php");
  require_once("../db/view_fahrplan_arrived_person.php");


  $template->addVar("main","CONTENT_TITLE","Reports: Persons");
  $template->addVar("main","VIEW_TITLE", "Reports");


  $person = new View_Fahrplan_arrived_Person;
  $person->select(array('conference_id' => $preferences['conference'], 'f_arrived' => 'f'));

  $result = array();
  $template->addVar("report", "TOTAL_SUM", $person->get_count());

  foreach($person as $value) {
    array_push($result, array("IMAGE_URL"          => get_person_image_url($person),
                              "URL"                => get_person_url($person, "general"),
                              "NAME"               => $person->get('name')));
  }
  $template->addRows("report-list", $result);

?>
