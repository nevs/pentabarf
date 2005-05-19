<?php

  require_once("../db/event_type_localized.php");
  require_once("../db/event_state_localized.php");
  require_once("../db/language_localized.php");
  require_once("../db/conference_track.php");
  require_once("../db/event.php");


  $template->addVar("main","CONTENT_TITLE","Reports: Events");
  $template->addVar("main","VIEW_TITLE", "Reports");


  // get list of event states
  $state = new Event_State_Localized;
  $state->select(array('language_id' => $preferences['language']));

  $type = new Event_Type_Localized;
  $track = new Conference_Track;
  $language = new Language_Localized;

  $event = new Event;
  $event->select(array('event_state_id' => isset($_POST['status_selector']) ? $_POST['status_selector'] : $state->get('event_state_id'), 'conference_id' => $preferences['conference']));

  $result = array();
  foreach($event as $key){
    $type->clear();
    $type->select(array('event_type_id' => $event->get('event_type_id'), 'language_id' => $preferences['language']));
    if ($event->get('conference_track_id')) {
      $track->select(array('conference_track_id' => $event->get('conference_track_id')));
      $track_name = $track->get('tag');
    } else {
      $track_name = '';
    }
    
    if ($event->get('language_id')) {
      $language->select(array('translated_id' => $event->get('language_id'), 'language_id' => $preferences['language']));
    } else {
      $language->clear();
    }
    array_push($result, array(
      'URL'        => get_event_url($event),
      'IMAGE_URL'  => get_event_image_url($event),
      'TITLE'      => $event->get('title'),
      'SUBTITLE'   => $event->get('subtitle'),
      'EVENT_TYPE' => $type->get_count() ? $type->get('name') : "",
      'TRACK'      => $track_name,
      'DURATION'   => is_object($event->get('duration')) ? $event->get('duration')->format('%H:%M') : '',
      'LANGUAGE'   => $language->get_count() ? $language->get('name') : ""
    ));
    
  }
  $template->addRows("report_list", $result);
  $template->addVar("report", "DURATION", $event->get_duration(array('event_state_id' => isset($_POST['status_selector']) ? $_POST['status_selector'] : $state->get('event_state_id'), 'conference_id' => $preferences['conference'])));
  $template->addVar("report", "NUMBER", count($result));

  fill_select("status_selector", $state, "event_state_id", "name", isset($_POST['status_selector']) ? $_POST['status_selector'] : $state->get('event_state_id'), false, "report");


?>
