<?php

  require_once('../functions/error_handler.php');
  require_once('../functions/exception_handler.php');
  require_once('../db/auth_person.php');
  require_once('../db/view_envelopes.php');

  // authenticate Person
  $auth_person = new Auth_Person;
  $auth_person->set_language_id(120);

  $data = new View_Envelope;
  $data->select(2);

  foreach( $data as $key ) {
    echo $data->get("name")."|".$data->get("title")."|".$data->get("day")."|".$data->get("room")."|".$data->get("start_time")->format("%H:%M")."\n";
  
  }

?>
