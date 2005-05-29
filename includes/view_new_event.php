<?php

  require_once("../db/event.php");
  require_once("../db/event_rating.php");
  require_once("../db/conference.php");
  require_once("../db/conference_track.php");
  require_once("../db/event_type_localized.php");
  require_once("../db/person.php");
  require_once("../db/event_role_localized.php");
  require_once("../db/event_state_localized.php");
  require_once("../db/team.php");
  require_once("../db/event_role_state_localized.php");
  require_once("../db/event_person.php");
  require_once("../db/keyword_localized.php");
  require_once("../db/link_type.php");
  require_once("../db/room.php");
  require_once("../db/view_language.php");
  require_once("../functions/tabs.php");
  require_once("../functions/fill_select.php");
  require_once("../functions/rating_summary.php");
  require_once("../functions/template.php");
  require_once("../includes/common-event.php");
  require_once("Date.php");
 

  $event = new Event;

  if ( $event->check_authorisation( 'create_event' ) !== true ) {
    throw new Privilege_Exception("Not allowed to create new events.");
  }
  
  $event->create();

  $template->readTemplatesFromFile("view_event.tmpl");
  $template->addVar("main","CONTENT_TITLE","New Event");
  $template->addVar("main","VIEW_TITLE","New Event");
  $template->addVar("content", "IMAGE_URL", get_event_image_url($event, "64x64"));
  $template->setAttribute("register_handler", "visibility", "visible");

  // array with the names of the js-switched tabs
  $tab_names = array("persons", "general",  "description", "links", "resources");
 
  content_tabs($tab_names, $template);

  
  // put event data into template
  member_to_template($event, array('f_public', 'start_time', 'f_paper', 'f_slides'));
  $template->addVar("content","F_PUBLIC","checked='checked'");
  $template->addVar("content","F_PAPER","checked='checked'");
  $template->addVar("content","F_SLIDES","checked='checked'");


  // get list of conferences
  $conference = new Conference;
  $conference->select();
  fill_select("conference", $conference, "conference_id", "title", $preferences['conference'], FALSE);

  
  // get list of languages
  $language = new View_Language;
  $language->select(array("f_visible" => "t"));
  fill_select("language_id", $language, "translated_id", "name", $event->get("language_id"));
  
  
  // get list of conference tracks
  $track = new Conference_Track;
  $track->select(array("conference_id" => $preferences["conference"]));
  fill_select("conference_track", $track, "conference_track_id", "tag", $event->get("conference_track_id"));


  // get list of event types
  $event_type = new Event_Type_Localized;
  $event_type->select(array("language_id" => $preferences['language']));
  fill_select("event_type", $event_type, "event_type_id", "name", $event->get("event_type_id"));


  // get event duration
  $duration = array();
  if ($conference->select(array('conference_id' => $preferences['conference']))) {
    $time = clone $conference->get('timeslot_duration');
    $limit = $conference->get('max_timeslot_duration') ? $conference->get('max_timeslot_duration') : 10;
    for ($i = 0; $i < $limit; $i++) {
      array_push($duration, 
          array(  'VALUE'     => $time->format('%H:%M:%S'), 
                  'TEXT'      => $time->format('%H:%M'), 
                  'SELECTED'  => ""));
      $time->add($conference->get('timeslot_duration'));
    }
  }
  $template->addRows("duration",$duration);


  // get event states
  $event_state = new Event_State_Localized;
  $event_state->select(array("language_id" => $preferences['language']));
  fill_select("event_state", $event_state, "event_state_id", "name", $event->get("event_state_id"), false);

  
  // get teams 
  $team = new Team;
  $team->select(array("conference_id" => $preferences['conference']));
  fill_select("team", $team, "team_id", "tag", 0, true);


  // get list of rooms
  $room = new Room;
  $room->select(array("conference_id" => $preferences['conference']));
  fill_select("room", $room, "room_id", "short_name", 0);
  
  // get values for day und time selection
  $days = array();
  array_push($days, array('VALUE' => ""));
  for ($i = 1; $i <= $conference->get("days"); $i++)
  {
    array_push($days, array('VALUE' => $i, 'TEXT' => $i, 'SELECTED' => ""));
  }
  $template->addRows("day", $days);

  $timeslot = $conference->get("timeslot_duration");
  $offset = $conference->get("day_change");
  $current = new Date_Span;
  $temp = new Date_Span;
  $times = array();
  array_push($times, array('VALUE' => ""));
  while (!$current->day) {
    $temp->copy($current);
    $temp->add($offset);
    array_push($times, array('VALUE' => $current->format("%H:%M:%S"), 'TEXT' => $temp->format("%H:%M"), 'SELECTED' => ""));
    $current->add($timeslot);
  }
  $template->addRows("start_time", $times);
  

  $event_rating = new Event_Rating;
  $event_rating->create();
  // calculate rating summary
  rating_summary("DOCUMENTATION", $event_rating, "documentation");
  rating_summary("QUALITY", $event_rating, "quality");
  rating_summary("RELEVANCE", $event_rating, "relevance");


?>
