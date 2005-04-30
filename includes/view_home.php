<?php

  require_once("../db/person.php");
  require_once("../db/view_event_person_event.php");
  require_once("../db/conference_transaction.php");
  require_once("../db/event_transaction.php");
  require_once("../db/person_transaction.php");
  require_once("../functions/tabs.php");

  $person = new Person;
  $person->select(array('person_id' => $auth_person->get_auth_person_id()));

  $template->readTemplatesFromFile("view_home.tmpl");


  $template->addVar("main","CONTENT_TITLE","Pentabarf");
  $template->addVar("main","VIEW_TITLE", "Pentabarf");

  // array with the names of the tabs
  $tab_names = array("coordinator", "participant");
  content_tabs($tab_names, $template);

  $event = new View_Event_Person_Event;

  if ($event->select(array('event_role_tag' => 'coordinator', 'person_id' => $event->get_auth_person_id(), 'conference_id' => $preferences['conference'])))
  {
    $events = array();
    foreach($event as $key)
    {
      array_push($events, array(
        'URL'                 => get_event_url($event),
        'IMAGE_URL'           => get_event_image_url($event, "32x32"),
        'TITLE'               => $event->get('title'),
        'SUBTITLE'            => $event->get('subtitle'),
        'STATUS'              => $event->get('event_state'),
      ));
    }
    $template->addRows("event-coordinator",$events);
  } 

  if ($event->select(array('event_role_tag' => array('speaker', 'moderator'), 'person_id' => $event->get_auth_person_id(), 'conference_id' => $preferences['conference'])))
  {
    $events = array();
    foreach($event as $key)
    {
      array_push($events, array(
        'URL'                 => get_event_url($event),
        'IMAGE_URL'           => get_event_image_url($event, "32x32"),
        'TITLE'               => $event->get('title'),
        'SUBTITLE'            => $event->get('subtitle'),
        'STATUS'              => $event->get('event_state'),
      ));
    }
    $template->addRows("event-participant",$events);
  } 

?>
