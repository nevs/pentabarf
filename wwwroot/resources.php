<?php

  require_once('../functions/error_handler.php');
  require_once('../functions/exception_handler.php');
  require_once('../db/auth_person.php');
  require_once('../db/view_event.php');
  require_once('../db/view_event_person_person.php');

  // authenticate Person
  $auth_person = new Auth_Person;
  $auth_person->set_language_id(120);

  $events = new View_Event;
  $person = new View_Event_Person_Person;

  if ( $events->select(array('conference_id' => 2) ) ) {
     foreach( $events as $key ) {
       echo $events->get('event_id').'|';
       echo $events->get('title').'|';
       $person->select(array('event_id' => $events->get('event_id')));
       $persons = array();
       foreach( $person as $key ) {
         $persons[] = $person->get('name');
       }
       echo implode(', ', $persons).'|';
       echo $events->get('event_state').'|';
       echo str_replace( array("\r", "\n"), " ", $events->get('resources')."\r\n";
     }
  }
?>
