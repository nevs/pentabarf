<?php

  require_once("../db/person.php");
  require_once("../db/view_person_contact.php");


  $template->addVar("main","CONTENT_TITLE","Reports: Contact");
  $template->addVar("main","VIEW_TITLE", "Reports");


  $person = new View_Person_Travel;
  $person->select(array('conference_id' => $preferences['conference']));

  $result = array();

  foreach($person as $value) {
    array_push($result, array("IMAGE_URL"          => get_person_image_url($person),
                              "URL"                => get_person_url($person, "contact"),
                              "NAME"               => $person->get('name'),
                              "E_MAIL"             => $person->get('email_contact'),
                              "TELEPHONE"          => $person->get('telephone'),
                              "MOBILE"             => $person->get('mobile'),
                              "DECT"               => $person->get('dect')
    ));
  }
  $template->addRows("report-list", $result);

?>
