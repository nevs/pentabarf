<?php

  require_once('../db/conference.php');
  require_once('../db/conference_track.php');
  require_once('../db/team.php');
  require_once('../db/country_localized.php');
  require_once('../db/time_zone.php');
  require_once('../db/time_zone_localized.php');
  require_once('../db/currency.php');
  require_once('../db/view_language.php');
  require_once('../db/link_type.php');
  require_once('../db/conference_link.php');
  require_once('../db/person_watchlist_conference.php');
  require_once('../db/person_watchlist_event.php');
  require_once('../db/room.php');
  require_once('../db/conference_person.php');
  require_once('../db/conference_role_localized.php');
  require_once('../db/conference_transaction.php');
  require_once('../db/view_event_rating_public.php');
  require_once('../functions/tabs.php');
  require_once('../functions/fill_select.php');
  require_once('../functions/rating_summary.php');
  require_once('../includes/common-conference.php');

  $template->readTemplatesFromFile('view_conference.tmpl');
  $template->setAttribute('register_handler', 'visibility', 'visible');

  // array with the names of the js-switched tabs
  $tab_names = array('general', 'persons', 'tracks', 'rooms', 'events', 'releases', 'export', 'feedback');

  content_tabs($tab_names, $template);

  $conference = new Conference;

  if (!$conference->select(array("conference_id" =>($RESOURCE ? $RESOURCE : $preferences['conference'])))) {
    header("Location: ".get_url("find_conference"));
    exit;
  }

  $transaction = new Conference_Transaction;
  if ( $transaction->select(array("conference_id" => $conference->get("conference_id"))) ) {
    $template->addVar("content", "TIMESTAMP", $transaction->get("changed_when"));
  }

  if (!$RESOURCE) header("Location: ".get_url("conference/".$preferences['conference']));

  $template->addVar("main","CONTENT_TITLE", $conference->get("title"));
  $template->addVar("main","VIEW_TITLE","View Conference");
  $template->addVar("content", "IMAGE_URL", get_conference_image_url($conference, "64x64", false));


  // is the event watched  
  $person_watchlist_conference = new Person_Watchlist_Conference;
  if ($person_watchlist_conference->select(array("person_id" => $conference->get_auth_person_id(),"conference_id" => $conference->get("conference_id")))) {
    $template->addVar("watch-button","WATCH_BUTTON",$GLOBAL_TEXT_WATCHED );
  } else {
    $template->addVar("watch-button","WATCH_BUTTON", $GLOBAL_TEXT_UNWATCHED );
  }
  $template->addVar("watch-button","CONFERENCE_ID", $conference->get("conference_id"));


  // write data into template
  foreach($conference->get_field_names() as $value) {
    if($conference->get($value) instanceof Date) {
      $template->addVar("content",strtoupper($value),$conference->get($value)->format("%Y-%m-%d"));
    } elseif ($conference->get($value) instanceof Date_Span) {
      $template->addVar("content",strtoupper($value),$conference->get($value)->format("%H:%M:%S"));
    } else {
      $template->addVar("content",strtoupper($value),$conference->get($value));
    }
  }

  for ($i = 1; $i < 24; $i++){
    $days[$i-1] = array(  
        'VALUE'     => $i,
        'TEXT'      => $i,
        'SELECTED'  => $i == $conference->get("days") ? "selected='selected'" : "");
  }
  $template->addRows('days',$days);
 
  $max_timeslot = array();
  array_push($max_timeslot, array('VALUE' => '', 'SELECTED' => $conference->get('max_timeslot_duration') == 0 ? "selected='selected'" : ''));
  for ($i = 1; $i < 25; $i++){
    array_push($max_timeslot, array('VALUE'    => $i,
                                    'TEXT'     => $i,
                                    'SELECTED' => $i == $conference->get('max_timeslot_duration') ? "selected='selected'" : ''));
  }
  $template->addRows('max_timeslot_duration', $max_timeslot);

  $country = new Country_Localized;
  $country->select(array('language_id' => $preferences['language']));
  fill_select('country', $country, 'country_id', 'name', $conference->get('country_id'));

  $time_zone = new Time_Zone;
  $time_zone_localized = new Time_Zone_Localized;
  $time_zone->select();
  $time_zones[0] = array('VALUE' => 0,'TEXT' =>'');
  foreach($time_zone as $key) {
    $time_zone_localized->select(array('time_zone_id' => $time_zone->get('time_zone_id'),'language_id' => $preferences['language']));
    $time_zones[$key] = array('VALUE' => $time_zone->get('time_zone_id'), 'TEXT' => $time_zone_localized->get('name'), 'SELECTED' => $time_zone->get('time_zone_id') == $conference->get('time_zone_id') ? "selected='selected'" : '');
  }
  $template->addRows('time_zone',$time_zones);
  
  $currency = new Currency;
  $currency->select(array('f_visible'=> 't'));
  fill_select('currency', $currency, 'currency_id', 'iso_4217_code', $conference->get('currency_id'));

  $language = new View_Language;
  $language->select(array('f_visible' => 't', 'language_id' => $preferences['language']));
  fill_select('primary_language', $language, 'translated_id', 'name', $conference->get('primary_language_id'));
  fill_select('secondary_language', $language, 'translated_id', 'name', $conference->get('secondary_language_id'));


  $timeslot_duration = new Date_Span;
  $delta = new Date_Span('0:05:00','%H:%M:%S');
  $timeslot_durations = array();
  while($timeslot_duration->toMinutes() < 120) {
    $timeslot_duration->add($delta);
    array_push($timeslot_durations, 
        array('VALUE'    => $timeslot_duration->format('%H:%M:%S'), 
              'TEXT'     => $timeslot_duration->format('%F min'), 
              'SELECTED' => $timeslot_duration->equal($conference->get('timeslot_duration')) ? "selected='selected'" : ""));
  }
  $template->addRows('timeslot_duration',$timeslot_durations);
 
  $day_change = new Date_Span;
  $delta = new Date_Span('1:00:00','%H:%M:%S');
  $day_changes = array();
  while($day_change->day != 1) {
    array_push($day_changes, 
        array('VALUE'    => $day_change->format('%H:%M:%S'), 
              'TEXT'     => $day_change->format('%H:%M'), 
              'SELECTED' => $day_change->equal($conference->get('day_change')) ? "selected='selected'" : ""));
    $day_change->add($delta);
  }
  $template->addRows('day_change',$day_changes);
 

  $track = new Conference_Track;
  if ($track->select(array('conference_id' => $conference->get('conference_id')))) {
    add_js_init_function('add_conference_track', $track, array('conference_track_id', 'tag'));
  }


  $team = new Team;
  if ($team->select(array('conference_id' => $conference->get('conference_id')))) {
    add_js_init_function('add_team', $team, array('team_id', 'tag'));
  }


  $room = new Room;
  if ($room->select(array('conference_id' => $conference->get('conference_id')))) {
    add_js_init_function('add_room', $room, array('room_id', 'short_name', 'f_public', 'size', 'remark', 'rank'));
  }

  
  // get conference links
  $conference_link = new Conference_Link;
  if ($conference_link->select(array('conference_id' => ($conference->get('conference_id'))))) {
    add_js_init_function('add_link', $conference_link, array('conference_link_id', 'link_type_id', 'url', 'title', 'description'));
  }
  

  // add existing conference persons to the page
  $person = new Conference_Person;
  if ($person->select(array('conference_id' => $conference->get('conference_id')))) {
    add_js_init_function('add_conference_person', $person, array('conference_person_id', 'person_id', 'conference_role_id', 'remark'));
  }


  // Get a list of the events of the current conference
  $event = new Event;
  $watchlist = new Person_Watchlist_Event;
  if ($event->select(array('conference_id' => $conference->get('conference_id'))))
  {
    $events = array();
    foreach($event as $key)
    {
      array_push($events, array(
          'URL'          => get_event_url($event),
          'IMAGE_URL'    => get_event_image_url($event),
          'TITLE'        => $event->get('title'),
          'SUBTITLE'     => $event->get('subtitle'),
          'EVENT_ID'     => $event->get('event_id'),
          'WATCH_BUTTON' => $watchlist->select(array('person_id' => $event->get_auth_person_id(), 'event_id' => $event->get('event_id'))) ? $GLOBAL_TEXT_WATCHED : $GLOBAL_TEXT_UNWATCHED));
    }
    $template->addRows('event_list_elements', $events);
  }
  
  $event_feedback = new View_Event_Rating_Public;
  $event_feedback->select(array('conference_id' => $conference->get('conference_id')));
  rating_summary('PARTICIPANT_KNOWLEDGE', $event_feedback, 'participant_knowledge');
  rating_summary('TOPIC_IMPORTANCE', $event_feedback, 'topic_importance');
  rating_summary('CONTENT_QUALITY', $event_feedback, 'content_quality');
  rating_summary('PRESENTATION_QUALITY', $event_feedback, 'presentation_quality');
  rating_summary('AUDIENCE_INVOLVEMENT', $event_feedback, 'audience_involvement');


?>
