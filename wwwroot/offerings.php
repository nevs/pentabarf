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

  if ( $events->select(array('conference_id' => 2, 'event_state_tag' => 'offering' ) ) ) {
     foreach( $events as $key ) {
        $line = $events->get('event_id').'|';
        $line .= $events->get('title').'|';
        $line .= $events->get('abstract').'|';
        $person->select(array('event_id' => $events->get('event_id'), 'event_role_tag' => array( 'moderator', 'speaker' ) ) );
        $persons = array();
        $persons[0]['name'] = "";
        $persons[0]['description'] = "";
        foreach( $person as $key ) {
           $persons[$key]['name'] = $person->get('name');
           $persons[$key]['description'] = $person->get('description');
        }
        $line .= $persons[0]['name'].'|';
        $line .= $persons[0]['description'].'|';
        $line .= $events->get('remark');

        // remove bad character
        $line = str_replace( array("\r", "\n"), " ", $line );
        echo $line."\r\n";

        // print additional speaker on new lines
        foreach( $persons as $key => $value ) {
           if ( $key == 0 ) continue;
           $line = "|||".$value['name']."|".$value['description']."|";
           $line = str_replace( array("\r", "\n"), " ", $line );
           echo $line."\r\n";
        }
     }
  }
?>
