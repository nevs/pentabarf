<?php

  require_once('../includes/globals.php');
  require_once('../functions/error_handler.php');
  require_once('../functions/exception_handler.php');
  require_once('../patError/patErrorManager.php');
  require_once('../patTemplate/patTemplate.php');
  require_once('../db/auth_person.php');
  require_once('../db/event_state.php');
  require_once('../db/event_state_localized.php');
  require_once('../db/view_event_person_person.php');
  require_once('../functions/get_url.php');


  // authenticate Person
  $auth_person = new Auth_Person;
  $preferences = $auth_person->get('preferences');

  // put URL parts in $VIEW, $RESOURCE and $OPTIONS
  $OPTIONS = explode('/',$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);

  $state = new Event_State;
  $state->set_order('rank');
  $state->select();
  $state_local = new Event_State_Localized;
  $event = new Event;
  $coordinator = new View_Event_Person_Person;

  foreach( $state as $key ) {
    if ($event->select(array('event_state_id' => $state->get('event_state_id'), 'conference_id' => $RESOURCE ) ) ) {
      $state_local->select(array('event_state_id' => $state->get('event_state_id'), 'language_id' => $preferences['language']));
      echo "Events with state '{$state_local->get('name')}'\n\n";
      foreach( $event as $key ) {
         echo "Title: {$event->get('title')}\n"; 
         echo "Subtitle: {$event->get('subtitle')}\n"; 
         if ($coordinator->select(array('event_id' => $event->get('event_id'), 'event_role_tag' => 'coordinator'))) {
            echo "Coordinator: {$coordinator->get('name')}\n";
         }
         echo "Abstract:\n{$event->get('abstract')}\n"; 
         echo "Description:\n{$event->get('description')}\n"; 
         echo "Event Persons:\n";
         $coordinator->select(array('event_id' => $event->get('event_id')));
         foreach ($coordinator as $key) {
            if ($coordinator->get('event_role_tag') == 'coordinator') continue;
            echo "Name: {$coordinator->get('name')}\n";
            echo "Abstract: {$coordinator->get('abstract')}\n";
            echo "Description: {$coordinator->get('description')}\n";
         }
         echo "\n\n";
      }
      echo "\n";
    }
  }


?>
