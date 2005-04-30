<?php

  require_once("../db/view_person.php");
  require_once("../db/view_watchlist_person.php");
  require_once("../db/view_watchlist_event.php");
  require_once("../db/view_watchlist_conference.php");
  require_once("../db/conference_transaction.php");
  require_once("../db/event_transaction.php");
  require_once("../db/person_transaction.php");
  require_once("../db/event_state_localized.php");
  require_once("../functions/tabs.php");


  $template->readTemplatesFromFile("view_watchlist.tmpl");


  $template->addVar("main","CONTENT_TITLE","Your Watchlist");
  $template->addVar("main","VIEW_TITLE", "Your Watchlist");


  // array with the names of the tabs
  $tab_names = array("persons", "events", "conferences");
  content_tabs($tab_names, $template);


  // get watched persons
  $person = new View_Watchlist_Person;
  if ($person->select(array('watcher_person_id' => $person->get_auth_person_id())))
  {
    $persons = array();
    foreach($person as $key)
    {
      array_push($persons, array(
        'URL'           => get_person_url($person),
        'IMAGE_URL'     => get_person_image_url($person, "32x32"),
        'NAME'          => $person->get('name'),
        'PERSON_ID'     => $person->get('watched_person_id'),
        'WATCH_BUTTON'  => "WATCHED"
      ));
    }
    $template->addRows("watchlist_person",$persons);
  }
   

  // get watched events
  $event = new View_Watchlist_Event;
  $conference = new Conference;
  $event_state = new Event_State_Localized;
  $event_state->select(array('language_id' => $preferences['language']));
  $event_states = array();
  foreach($event_state as $key) {
    $event_states[$event_state->get('event_state_id')] = $event_state->get('name');
  }


  if ($event->select(array('person_id' => $event->get_auth_person_id())))
  {
    $watched_events = array();
    foreach($event as $key)
    {
      $conference->select(array('conference_id' => $event->get('conference_id')));
      array_push($watched_events, array(
        'URL'                 => get_event_url($event),
        'IMAGE_URL'           => get_event_image_url($event, "32x32"),
        'TITLE'               => $event->get('title'),
        'SUBTITLE'            => $event->get('subtitle'),
        'STATUS'              => $event_states[$event->get('event_state_id')],
        'CONFERENCE_ACRONYM'  => $conference->get('acronym'),
        'EVENT_ID'            => $event->get('event_id'),
        'WATCH_BUTTON'        => "WATCHED"
      ));
    }
    $template->addRows("watchlist_event",$watched_events);
  } 

  // get watched conferences
  $conference = new View_Watchlist_Conference;
  if ($conference->select(array('person_id' => $conference->get_auth_person_id())))
  {
    $watched_conferences = array();
    foreach($conference as $key)
    {
      array_push($watched_conferences, array(
        'URL'           => get_conference_url($conference),
        'IMAGE_URL'     => get_conference_image_url($conference, "32x32"),
        'TITLE'         => $conference->get('title'),
        'ACRONYM'       => $conference->get('acronym'),
        'CONFERENCE_ID' => $conference->get('conference_id'),
        'WATCH_BUTTON'  => "WATCHED"
      ));
    }
    $template->addRows("watchlist_conference",$watched_conferences);
  } 

?>
