<?php

  require_once('../db/view_event.php');
  require_once('../db/view_fahrplan_person.php');
  require_once('../db/view_fahrplan_event.php');
  require_once('../db/view_event_attachment.php');
  require_once('../db/view_event_person_with_role.php');
  require_once('../db/conflict_event_time.php');
  require_once('../db/conflict_event_incomplete.php');
  require_once('../db/conflict_person_time.php');
  require_once('../db/conflict_event_no_speaker.php');
  require_once('../db/conflict_event_no_coordinator.php');
  require_once('../db/conflict_person_event_language.php');


  function add_conflict_event($conflict, $reason, &$array) {
    array_push($array, array(
      'URL'       => get_event_url($conflict,'description'),
      'TITLE_URL' => array(get_event_url($conflict,'description')),
      'IMAGE_URL' => get_event_image_url($conflict),
      'REASON'    => $reason,
      'TITLE'     => array($conflict->get('title'))
    ));
  }

  function add_conflict_event2($conflict, $reason, &$array)
  {
    foreach($conflict as $key)
    {
      array_push($errors, array(
        'URL'       => get_event_url($conflict->get('event_id1'),'general'),
        'TITLE_URL' => array( get_event_url($conflict->get('event_id1'),'general'), get_event_url($conflict->get('event_id2'),'general')),
        'IMAGE_URL' => get_event_image_url(0),
        'REASON'    => $reason,
        'TITLE'     => array($conflict->get('title1'), $conflict->get('title2'))
      ));
    }
  }


  $template->readTemplatesFromFile('view_conflicts.tmpl');
  $template->addVar('main','CONTENT_TITLE','Conflicts');
  $template->addVar('main','VIEW_TITLE', 'Conflicts');

  // array with the names of the js-switched tabs
  $tab_names = array('errors', 'warnings');

  content_tabs($tab_names, $template);

  $errors = array();
  $warnings = array();

  $person = new View_Fahrplan_Person;

  
  // events with conflicting timeslots
  $conflict = new Conflict_Event_Time;
  $conflict->select(array('conference_id' => $preferences['conference']));
  foreach($conflict as $key)
  {
    array_push($errors, array(
      'URL'       => get_event_url($conflict->get('event_id1'),'general'),
      'TITLE_URL' => array( get_event_url($conflict->get('event_id1'),'general'), get_event_url($conflict->get('event_id2'),'general')),
      'IMAGE_URL' => get_event_image_url(0),
      'REASON'    => 'Doppelt belegter Timeslot',
      'TITLE'     => array($conflict->get('title1'), $conflict->get('title2'))
    ));
  }

  
  // events with conflicting timeslots
  $conflict = new Conflict_Person_Time;
  $conflict->select(array('conference_id' => $preferences['conference']));
  foreach($conflict as $key)
  {
    array_push($errors, array(
      'URL'       => get_person_url($conflict->get('person_id'),'events'),
      'TITLE_URL' => array( get_event_url($conflict->get('event_id1'),'general'), get_event_url($conflict->get('event_id2'),'general')),
      'IMAGE_URL' => get_person_image_url($conflict->get('person_id')),
      'REASON'    => 'Moderator/Referent in 2 Veranstaltungen gleichzeitig',
      'TITLE'     => array($conflict->get('title1'), $conflict->get('title2'))
    ));
  }


  // speaker/moderator doesn't speak the language of the event
  $conflict = new Conflict_Person_Event_Language;
  $conflict->select(array('conference_id' => $preferences['conference']));
  foreach($conflict as $key)
  {
    array_push($errors, array(
      'URL'       => get_person_url($conflict->get('person_id'),'events'),
      'TITLE_URL' => array( get_person_url($conflict->get('person_id'),'general'), get_event_url($conflict->get('event_id'), 'general')),
      'IMAGE_URL' => get_person_image_url($conflict->get('person_id')),
      'REASON'    => 'Moderator/Referent spricht nicht die Sprache der Veranstaltung',
      'TITLE'     => array($conflict->get('name'), $conflict->get('title'))
    ));
  }

  
  // event with incomplete day/time/room
  $conflict = new Conflict_Event_Incomplete;
  $conflict->select(array('conference_id' => $preferences['conference']));
  foreach($conflict as $key)
  {
    array_push($errors, array(
      'URL'       => get_event_url($conflict->get('event_id'),'persons'),
      'TITLE_URL' => array( get_event_url($conflict->get('event_id'),'persons')),
      'IMAGE_URL' => get_event_image_url($conflict->get('event_id')),
      'REASON'    => 'Event mit unvollstaendigen Zeit/Raum/Tag - Daten',
      'TITLE'     => array($conflict->get('title'))
    ));
  }

  
  // public event without speaker/moderator
  $conflict = new Conflict_Event_No_Speaker;
  $conflict->select(array('conference_id' => $preferences['conference']));
  foreach($conflict as $key)
  {
    array_push($errors, array(
      'URL'       => get_event_url($conflict->get('event_id'),'persons'),
      'TITLE_URL' => array( get_event_url($conflict->get('event_id'),'persons')),
      'IMAGE_URL' => get_event_image_url($conflict->get('event_id')),
      'REASON'    => 'Event ohne Referent/Moderator',
      'TITLE'     => array($conflict->get('title'))
    ));
  }

  
  // speaker without email
  $person->select(array('conference_id' => $preferences['conference'], 'email_contact' => false));
  foreach($person as $key){
    array_push($warnings, array(
      'URL'       => get_person_url($person,'contact'),
      'TITLE_URL' => array(get_person_url($person,'contact')),
      'IMAGE_URL' => get_person_image_url($person),
      'REASON'    => 'Referent ohne E-Mail-Adresse',
      'TITLE'     => array($person->get('name'))
    ));
  }

  // event without coordinator
  $event = new Conflict_Event_No_Coordinator;
  $event->select(array('conference_id' => $preferences['conference']));
  foreach($event as $key) {
    add_conflict_event($event, 'Event ohne Koordinator', $warnings);
  }

  // events without abstract
  $event = new View_Event;
  $event->select(array('event_state_tag' => 'confirmed', 'abstract' => false, 'f_public' => 't', 'conference_id' => $preferences['conference']));
  foreach($event as $key){
    add_conflict_event($event, 'Event ohne Abstract', $errors);
  }


  // events without conference track 
  $event = new View_Event;
  $event->select(array('event_state_tag' => 'confirmed', 'conference_track_id' => false, 'f_public' => 't', 'conference_id' => $preferences['conference']));
  foreach($event as $key){
    add_conflict_event($event, 'Event ohne Track', $warnings);
  }


  // events without description 
  $event = new View_Event;
  $event->select(array('event_state_tag' => 'confirmed', 'description' => false, 'f_public' => 't', 'conference_id' => $preferences['conference']));
  foreach($event as $key){
    add_conflict_event($event, 'Event ohne Beschreibung', $warnings);
  }


  // events without paper
  $event = new View_Event;
  $attachment = new View_Event_Attachment;
  $event->select(array('event_state_tag' => 'confirmed', 'f_paper' => 't', 'f_public' => 't', 'conference_id' => $preferences['conference']));
  foreach($event as $key){
    if ($attachment->select(array('event_id' => $event->get('event_id'), 'attachment_type_tag' => 'paper')) == 0) {
      add_conflict_event($event, 'Event ohne Paper', $errors);
    }
  }


  // events without slides 
  $event = new View_Event;
  $attachment = new View_Event_Attachment;
  $event->select(array('event_state_tag' => 'confirmed', 'f_slides' => 't', 'f_public' => 't', 'conference_id' => $preferences['conference']));
  foreach($event as $key){
    if ($attachment->select(array('event_id' => $event->get('event_id'), 'attachment_type_tag' => 'slides')) == 0) {
      add_conflict_event($event, 'Event ohne Slides', $errors);
    }
  }


  // count errors and warnings and add everything to the template

  $template->addVar('content', 'ERROR_COUNTER', count($errors));
  if (count($errors)) {
    $template->addRows('error-list', $errors);
  }
  $template->addVar('content', 'WARNING_COUNTER', count($warnings));
  if (count($warnings)) {
    $template->addRows('warning-list', $warnings);
  }

?>
