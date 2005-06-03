<?php

  require_once('../db/person.php');
  require_once('../db/event.php');
  require_once('../db/conference.php');
  require_once('../db/view_event_person_person.php');
  require_once('../db/event_person.php');
  require_once('../db/person_watchlist_event.php');
  require_once('../db/event_state_localized.php');
  require_once('../db/event_type_localized.php');
  require_once('../db/view_language.php');
  require_once('../db/find_event.php');
  require_once('../db/conference_track.php');
  require_once('../db/keyword_localized.php');
  require_once('../db/event_role.php');
  require_once('../db/room.php');
  require_once('../db/team.php');
  require_once('../db/attachment_type.php');
  require_once('../functions/tabs.php');
  require_once('../functions/search.php');

  if (isset($_POST['find_events']) || isset($_POST['search'])) {
    if (isset($_POST['find_events'])) {
      // simple search
      $preferences['find_events'] = $_POST['find_events'];
      $preferences['find_events_type'] = 'simple';
    
    } else if (isset($_POST['search'])) {
      // advanced search
      $preferences['find_events_advanced'] = $_POST['search'];
      usort($preferences['find_events_advanced'], 'compare_search');
      $preferences['find_events_type'] = 'advanced';
    }
    $auth_person->set('preferences', $preferences);
    if ($auth_person->check_authorisation('modify_own_person')) {
      $auth_person->write();
    }
    header("Location: {$BASE_URL}pentabarf/find_event");
    exit;
  }
  
  $template->readTemplatesFromFile("view_find_event.tmpl");
  $template->addVar("main","CONTENT_TITLE", "Find Event");
  $template->addVar("main","VIEW_TITLE", "Find Event");
  

  // array with the names of the js-switched tabs
  $tabnames = array("simple", "advanced");
  content_tabs($tabnames, $template, $preferences['find_events_type']);


  // get list of event states
  $event_state = new Event_State_Localized;
  $event_state->select(array('language_id' => $preferences['language']));
  add_js_vars("valuelists[1]", $event_state, 'event_state_id', 'name', $is_array = true);

  // get list of languages
  $language = new View_Language;
  $language->select(array('language_id' => $preferences['language'], 'f_visible' => 't'));
  add_js_vars("valuelists[2]", $language, 'translated_id', 'name', $is_array = true, $add_empty = true);

  // get list of conference tracks
  $track = new Conference_Track;
  $track->select(array('conference_id' => $preferences['conference']));
  add_js_vars("valuelists[3]", $track, 'conference_track_id', 'tag', $is_array = true, $add_empty = true);
  
  // get list of event types
  $type = new Event_Type_Localized;
  $type->select(array('language_id' => $preferences['language']));
  add_js_vars("valuelists[4]", $type, 'event_type_id', 'name', $is_array = true, $add_empty = true);
  
  // get list of keywords
  $keyword = new Keyword_Localized;
  $keyword->select(array('language_id' => $preferences['language']));
  add_js_vars("valuelists[6]", $keyword, 'keyword_id', 'name', $is_array = true);
 
  // get list of coordinators
  $person = new View_Event_Person_Person;
  $person->select(array('event_role_tag' => 'coordinator'));
  add_js_vars("valuelists[7]", $person, 'person_id', 'name', $is_array = true);

  // get list of speaker
  $person = new View_Event_Person_Person;
  $person->select(array('event_role_tag' => 'speaker'));
  add_js_vars("valuelists[8]", $person, 'person_id', 'name', $is_array = true);

  // get possible event durations
  $durations = array();
  $conference = new Conference;
  $conference->select(array('conference_id' => $preferences['conference']));
  $time = $conference->get('timeslot_duration');
  for ($i = 0; $i < $conference->get('max_timeslot_duration'); $i++) {
    $time->add($conference->get('timeslot_duration'));
    $durations[$time->format('%H:%M:%S')] = $time->format('%H:%M'); 
  }
  add_js_vars("valuelists[9]", $durations, 'duration', 'duration', $is_array = true);

  // get list of teams
  $team = new Team;
  $team->select(array('conference_id' => $preferences['conference']));
  add_js_vars("valuelists[10]", $team, 'team_id', 'tag', $is_array = true, $add_empty = true);
  
  // get list of rooms 
  $room = new Room;
  $room->select(array('conference_id' => $preferences['conference']));
  add_js_vars("valuelists[11]", $room, 'room_id', 'short_name', $is_array = true, $add_empty = true);
  
  // get list of days 
  $days = array();
  for ($i = 1; $i <= $conference->get('days'); $i++) $days[$i] = $i;
  add_js_vars("valuelists[12]", $days, '', '', $is_array = true, $add_empty = true);
  
  // get list of attachment-types
  $attachment_type = new Attachment_Type;
  $attachment_type->select();
  add_js_vars("valuelists[13]", $attachment_type, 'attachment_type_id', 'tag', $is_array = true, $add_empty = false);
  
  $event = new Find_Event;
  if ($preferences['find_events_type'] == 'advanced') {
    $search_set = $preferences['find_events_advanced'];
  } else {
    if (preg_match('/^[0-9 ]+$/', $preferences['find_events'])) {
      // searching for multiple ids
      $find = explode(' ', $preferences['find_events']);
      $search_set = array();
      foreach ($find as $value) {
        array_push($search_set, array('type' => 'event_id', 'logic' => 'is', 'value' => $value));
      }
    } else {
      $find = explode(' ', $preferences['find_events']);
      $search_set = array();
      foreach ($find as $value) {
        array_push($search_set, array('type' => 'title', 'logic' => 'contains', 'value' => $value)); 
      }
    }
  }
  array_push($search_set, array('type' => 'conference_id', 'logic' => 'is', 'value' => $preferences['conference']));
  
  $count = $event->select($search_set);

  if (!$count) {
    // nothing found
    $template->addVar("result","RESULT","Nothing found");
    
  } else {

    $event_state = new Event_State_Localized;
    $event_state->select(array('language_id' => $preferences['language']));
    $event_states = array();
    foreach($event_state as $key) {
      $event_states[$event_state->get('event_state_id')] = $event_state->get('name');
    }

    $result = array();
    $watchlist = new Person_Watchlist_Event;
    $event_person = new Event_Person;
    $event_role = new Event_Role;
    $day_change = new Date_Span($conference->get('day_change'));
    $timeslot_sum = new Date_Span;

    foreach($event as $key) {
      if (is_object( $event->get('duration'))) $timeslot_sum->add($event->get('duration'));
      $event_state->select(array('event_state_id' => $event->get('event_state_id'), 'language_id' => $preferences['language']));
      $event_person->select(array('event_id' => $event->get('event_id')));
      $room = new Room;
      $room->select(array('room_id' => $event->get('room_id')));
      if (!$room->get_count()) $room->create();
      if (!$track->select(array('conference_track_id' => $event->get('conference_track_id')))) $track->create();
      $persons = array();
      $person_url = array();
      foreach($event_person as $value) {
        $event_role->select(array('event_role_id' => $event_person->get('event_role_id')));
        if ($event_role->get('tag') != 'speaker' && $event_role->get('tag') != 'moderator') continue;
        $person->select(array('person_id' => $event_person->get('person_id')));
        array_push($persons, $person->get('name'));
        array_push($person_url, get_person_url($person));
      }
      $start_time = $event->get('start_time');
      if ($start_time) 
        $start_time->add($day_change);
      array_push($result,array(
        'URL'            => get_event_url($event),
        'IMAGE_URL'      => get_event_image_url($event, "32x32"),
        'EVENT_ID'       => $event->get('event_id'),
        'TRACK'          => $track->get('tag'),
        'TITLE'          => $event->get('title'),
        'SUBTITLE'       => $event->get('subtitle'),
        'STATUS'         => $event_states[$event->get('event_state_id')],
        'ROOM'           => $room->get('short_name'),
        'DAY'            => $event->get('day'),
        'TIME'           => $start_time ? $start_time->format('%H:%M') : "",
        'WATCH_BUTTON'   => $watchlist->select(array('person_id' => $watchlist->get_auth_person_id(), 'event_id' => $event->get('event_id'))) ? $GLOBAL_TEXT_WATCHED : $GLOBAL_TEXT_UNWATCHED,
        'PERSON'         => $persons,
        'PERSON_URL'     => $person_url
        ));
    }
    $template->addVar("result", "RESULT", $count." Hit".($count == 1 ? "" : "s"));
    $template->addVar("result_list", "TIMESLOT_SUM", $timeslot_sum->format('%D days, %h hours and %m minutes'));
    $template->addRows("result_element", $result);
  }
  

  // rebuild the search set
  if (isset($preferences['find_events_advanced']) && 
      is_array($preferences['find_events_advanced']) && 
      count( $preferences['find_events_advanced'] ) ) {
    foreach($preferences['find_events_advanced'] as $value){
      array_push($init, array('FUNCTION' => "search_criteria_add('search_elements', 0, '".addslashes($value['type'])."', '".addslashes($value['logic'])."', '".addslashes($value['value'])."');"));
    }
  } else {
    array_push($init, array('FUNCTION' => "search_criteria_add('search_elements', 0);"));
  }
  $template->addVar("content", "FIND", $preferences['find_events']);

?>
