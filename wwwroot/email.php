<?php


  require_once('../functions/error_handler.php');
  require_once('../functions/exception_handler.php');
  require_once('../db/auth_person.php');
  require_once("../db/view_email.php");

  // authenticate Person
  $auth_person = new Auth_Person;
  $auth_person->set_language_id(120);

  $person = new View_Email;
  // $person->select(array('conference_id' => $preferences['conference']));
  $person->select(array('conference_id' => 2));

  $result = array();

  foreach($person as $value) {
    $result[] = $person->get('email_contact');
  }
  echo implode(", ", $result );

?>
