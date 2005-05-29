<?php

  require_once('../db/event.php');
  require_once('../db/event_rating.php');
  require_once('../db/conference.php');
  require_once('../db/conference_track.php');
  require_once('../db/event_type_localized.php');
  require_once('../db/event_role.php');
  require_once('../db/view_person.php');
  require_once('../db/event_state_localized.php');
  require_once('../db/team.php');
  require_once('../db/view_watchlist_event.php');
  require_once('../db/event_person.php');
  require_once('../db/language_localized.php');
  require_once('../db/view_event_link.php');
  require_once('../db/view_event_attachment.php');
  require_once('../db/attachment_type.php');
  require_once('../db/event_keyword.php');
  require_once('../db/mime_type.php');
  require_once('../db/room.php');
  require_once('../db/event_transaction.php');
  require_once('../db/view_language.php');
  require_once('../db/event_rating_public.php');
  require_once('../db/conflict_person_time.php');
  require_once('../db/conflict_person_event_language.php');
  require_once('../db/conflict_event_time.php');
  require_once('../db/conflict_event_incomplete.php');
  require_once('../db/related_event_keyword.php');
  require_once('../db/related_event_speaker.php');
  require_once('../db/event_related.php');
  require_once('../functions/tabs.php');
  require_once('../functions/fill_select.php');
  require_once('../functions/rating_summary.php');
  require_once('../functions/template.php');
  require_once('../includes/common-event.php');
  require_once('Date.php');

  
  $template->readTemplatesFromFile('view_event.tmpl');
  $template->setAttribute('register_handler', 'visibility', 'visible');


  // array with the names of the js-switched tabs
  $tab_names = array('persons', 'general', 'description', 'links', 'review', 'resources', 'related', 'feedback');
 
  content_tabs($tab_names, $template);

  // parse URL (decide witch event we are working with)

  $event = new Event;
  if (isset($_POST['select_event']) && $event->select(array('event_id' => $_POST['select_event'])) == 1) {
    header('Location: '.get_event_url($event));
    exit;
  } 
  
  if (!$event->select(array('event_id' => $RESOURCE ? $RESOURCE : (isset($preferences['current_event']) ? $preferences['current_event'] : 0)))) {
    header('Location: '.get_url('find_event'));
    exit;
  }

  if (!$RESOURCE) {
    header('Location: '.get_url('event/'.$preferences['current_event']));
    exit;
  }
  
  $transaction = new Event_Transaction;
  if ( $transaction->select(array('event_id' => $event->get('event_id'))) ) {
    $template->addVar("content", "TIMESTAMP", $transaction->get('changed_when'));
  }

  $template->addVar( "main", "CONTENT_TITLE", $event->get('title') . " [#" . $event->get('event_id') . "]");
  $template->addVar( "main", "VIEW_TITLE", "View Event");
  $template->addVar( "content", "IMAGE_URL", get_event_image_url($event, "64x64", false));
  
  // get conflicts for this event
  
  $reasons = array();
  $conflict = new Conflict_Event_Time;
  $conflict->select(array('conference_id' => $event->get('conference_id')), array('event_id1' => $event->get('event_id')));
  foreach($conflict as $key)
  {
    $reasons[] = array('REASON_URL' => get_event_url($conflict->get('event_id2')), 
                       'REASON' => 'Zeitliche Ueberschneidung mit '.$conflict->get('title2'));
  }
  $conflict = new Conflict_Event_Incomplete;
  $conflict->select(array('conference_id' => $event->get('conference_id')), array('event_id' => $event->get('event_id')));
  foreach($conflict as $key)
  {
    $reasons[] = array('REASON_URL' => get_event_url($conflict->get('event_id')), 
                       'REASON' => 'Unvollstaendige Zeit/Raum/Tag - Daten');
  }
  $conflict = new Conflict_Person_Time;
  $conflict->select(array('conference_id' => $event->get('conference_id')), array('event_id1' => $event->get('event_id')));
  foreach($conflict as $key)
  {
    $reasons[] = array('REASON_URL' => get_event_url($conflict->get('event_id2')), 
                       'REASON' => $conflict->get('name').' nimmt zu dieser Zeit bereits an '.$conflict->get('title2').' teil.');
  }
  $conflict = new Conflict_Person_Event_Language;
  $conflict->select(array('conference_id' => $event->get('conference_id')), array('event_id' => $event->get('event_id')));
  foreach($conflict as $key)
  {
    $reasons[] = array('REASON_URL' => get_person_url($conflict->get('person_id')), 
                       'REASON' => $conflict->get('name').' spricht nicht die Sprache dieser Veranstaltung.');
  }
  $template->addRows('conflicts', $reasons);
  


  // is the event watched  
  $person_watchlist_event = new View_Watchlist_Event;
  if ($person_watchlist_event->select(array('person_id' => $event->get_auth_person_id(), 'event_id' => $event->get('event_id')))) {
    $template->addVar("watch-button","WATCH_BUTTON", $GLOBAL_TEXT_WATCHED );
  } else {
    $template->addVar("watch-button","WATCH_BUTTON", $GLOBAL_TEXT_UNWATCHED );
  }
  $template->addVar("watch-button","EVENT_ID", $event->get('event_id'));


  // save current tab and event
  $preferences['current_event'] = $event->get('event_id');
  $auth_person->set('preferences', $preferences);
  if ($auth_person->check_authorisation("modify_own_person")) {
    $auth_person->write();
  }


  // select rating for event
  $event_rating = new Event_Rating;
  if (!$event_rating->select(array('person_id' => $event->get_auth_person_id(), 'event_id' => $event->get('event_id')))) {
    $event_rating->create();
    $event_rating->set('event_id', $event->get('event_id'));
    $event_rating->set('person_id', $event->get_auth_person_id());
  }

  // enable event navigation

  if ($event->get('event_id'))
  {
    $event_selection = new View_Watchlist_Event;

    // get all events
    $event_selection->select(array('conference_id' => $preferences['conference'], 'person_id' => $event_selection->get_auth_person_id()));

    fill_selector("event_list", $event_selection, "event_id", "title", $event->get('event_id'), $event);
    $template->setAttribute("event_navigation","visibility","visible");

  }

/*
 *********************************************************************
 * Everything below is fetching data and putting it in the templates *
 ********************************************************************* 
*/

  // put event data into template
  member_to_template($event, array('f_public', 'start_time', 'f_paper', 'f_slides'));
  if ($event->get('f_public') == 't') {
    $template->addVar("content","F_PUBLIC","checked='checked'");
  }
  if ($event->get('f_paper') == 't') {
    $template->addVar("content","F_PAPER","checked='checked'");
  }
  if ($event->get('f_slides') == 't') {
    $template->addVar("content","F_SLIDES","checked='checked'");
  }

  /* add rating fields to template */
  member_to_template($event_rating, array('documentation', 'quality', 'relevance', 'remark'));
  $template->addVar("content","DOCUMENTATION_".($event_rating->get('documentation') ? $event_rating->get('documentation') : "0"),"checked='checked'" );
  $template->addVar("content","QUALITY_".($event_rating->get('quality') ? $event_rating->get('quality') : "0"),"checked='checked'" );
  $template->addVar("content","RELEVANCE_".($event_rating->get('relevance') ? $event_rating->get('relevance') : "0"),"checked='checked'" );
  $template->addVar("content","RATING_REMARK", $event_rating->get('remark'));
 

  // get list of event_persons
  $event_person = new Event_Person;
  if ($event_person->select(array('event_id' => $event->get('event_id')))) {
    add_js_init_function("add_event_person", $event_person, array("event_person_id", "person_id", "event_role_id", "event_role_state_id", "remark"));
  }
  
  
  // get list of conferences
  $conference = new Conference;
  $conference->select();
  fill_select("conference", $conference, "conference_id", "title",$event->get('event_id') ? $event->get('conference_id') : $preferences['conference'], FALSE);

  
  // get list of languages
  $language = new View_Language;
  $language->select(array('f_visible' => 't', 'language_id' => $preferences["language"]));
  fill_select("language_id", $language, "translated_id", "name", $event->get('language_id'));
  
  
  // get list of conference tracks
  $track = new Conference_Track;
  $track->select(array('conference_id' => $event->get('conference_id')));
  fill_select("conference_track", $track, "conference_track_id", "tag", $event->get('conference_track_id'));

  
  // get list of event types
  $event_type = new Event_Type_Localized;
  $event_type->select(array('language_id' => $preferences['language']));
  fill_select("event_type", $event_type, "event_type_id", "name", $event->get('event_type_id'));

  
  // get list of rooms
  $room = new Room;
  $room->select(array('conference_id' => $event->get('conference_id')));
  fill_select("room", $room, "room_id", "short_name", $event->get('room_id'));
  

  // get event duration
  $duration = array();
  if ($conference->select(array('conference_id' => $event->get('conference_id')))) {
    $time = clone $conference->get('timeslot_duration');
    $limit = $conference->get('max_timeslot_duration') ? $conference->get('max_timeslot_duration') : 10;
    for ($i = 0; $i < $limit; $i++) {
      array_push($duration, 
          array(  'VALUE'     => $time->format('%H:%M:%S'), 
                  'TEXT'      => $time->format('%H:%M'), 
                  'SELECTED'  => $time->equal($event->get('duration'))? "selected='selected'" : ""));
      $time->add($conference->get('timeslot_duration'));
    }
  }
  $template->addRows("duration",$duration);

  
  // calculate rating summary
  $event_rating->select(array('event_id' => $event->get('event_id')));
  rating_summary("DOCUMENTATION", $event_rating, "documentation");
  rating_summary("QUALITY", $event_rating, "quality");
  rating_summary("RELEVANCE", $event_rating, "relevance");

  $event_feedback = new Event_Rating_Public;
  $event_feedback->select(array('event_id' => $event->get('event_id')));
  rating_summary("PARTICIPANT_KNOWLEDGE", $event_feedback, "participant_knowledge");
  rating_summary("TOPIC_IMPORTANCE", $event_feedback, "topic_importance");
  rating_summary("CONTENT_QUALITY", $event_feedback, "content_quality");
  rating_summary("PRESENTATION_QUALITY", $event_feedback, "presentation_quality");
  rating_summary("AUDIENCE_INVOLVEMENT", $event_feedback, "audience_involvement");

  // get list of attachments
  $attachment = new View_Event_Attachment;
  $type = new Attachment_Type;
  $type->select();
  if ($attachment->select(array('event_id' => $event->get('event_id'))))
  {
    $attachments = array();
    foreach($attachment as $key) {
      $text = array();
      $value = array();
      $selected = array();
      foreach($type as $v) {
        array_push($text, $type->get('tag'));
        array_push($value, $type->get('attachment_type_id'));
        array_push($selected, $type->get('attachment_type_id') == $attachment->get('attachment_type_id') ? "selected='selected'" : "");
      }

      $filesize = $attachment->get('filesize');
      if ($filesize < 900) {
          $filesize .= ' Byte';
      } else if ($filesize < 900000) {
          $filesize /= 1024;
          $filesize = sprintf('%.1f', $filesize);
          $filesize .= ' KByte';
      } else {
          $filesize /= 1048576;
          $filesize = sprintf('%.1f', $filesize);
          $filesize .= ' MByte';
      }

      $mime_type_id = $attachment->get('mime_type_id');
      $mime_type = new MIME_TYPE;
      $mime_type->select(array('mime_type_id' => $mime_type_id));

      array_push($attachments, array(
          'ATTACHMENT_ID' => $attachment->get('event_attachment_id'),
          'TITLE'         => $attachment->get('title'),
          'FILENAME'      => $attachment->get('filename'),
          'FILESIZE'      => $filesize,
          'TEXT'          => $text,
          'VALUE'         => $value,
          'SELECTED'      => $selected,
          'F_PUBLIC'      => $attachment->get('f_public') == 't' ? "checked='checked'" : "",
          'MIME_TYPE'     => $mime_type->get('mime_type');
          'URL'           => get_attachment_url($attachment)));
    }
    $template->addRows("attachments", $attachments);
  }
  

  // get event_states
  $event_state = new Event_State_Localized;
  $event_state->select(array('language_id' => $preferences['language']));
  fill_select("event_state", $event_state, "event_state_id", "name", $event->get('event_state_id'), FALSE);

 
  // get teams 
  $team = new Team;
  $team->select(array('conference_id' => $event->get('conference_id')));
  fill_select("team", $team, "team_id", "tag", $event->get('team_id'), true);


  // get public event links
  $event_link = new View_Event_Link;
  if ($event_link->select(array('event_id' => $event->get('event_id'), 'f_public' => 't'))) {
    add_js_init_function("add_public_link", $event_link, array("event_link_id", "link_type_id", "url", "title", "description"));
  }

  // get internal event links
  $event_link = new View_Event_Link;
  if ($event_link->select(array('event_id' => $event->get('event_id'), 'f_public' => 'f'))) {
    add_js_init_function("add_internal_link", $event_link, array("event_link_id", "link_type_id", "url", "title", "description"));
  }



  // add existing keywords
  $event_keyword = new Event_Keyword;
  if ($event_keyword->select(array('event_id' => $event->get('event_id')))) {
    add_js_init_function("add_keyword", $event_keyword, "keyword_id");
  }

  // get values for day und time selection
  $conference = new Conference;
  $conference->select(array('conference_id' => $event->get('conference_id')));
  $start_time = $event->get('start_time');
  $days = array();
  array_push($days, array('VALUE' => "", 'SELECTED' => !$start_time ? "selected='selected'" : ""));
  for ($i = 1; $i <= $conference->get('days'); $i++)
  {
    array_push($days, array('VALUE'    => $i,
                            'TEXT'     => $i,
                            'SELECTED' => $event->get('day') == $i ? "selected='selected'" : ""));
  }
  $template->addRows("day", $days);

  $timeslot = $conference->get('timeslot_duration');
  $offset = $conference->get('day_change');
  $current = new Date_Span;
  $temp = new Date_Span;
  $times = array();
  array_push($times, array('VALUE' => "", 'SELECTED' => !$start_time ? "selected='selected'" : ""));
  while (!$current->day) {
    $temp->copy($current);
    $temp->add($offset);
    array_push($times, array('VALUE' => $current->format("%H:%M:%S"), 
                             'TEXT' => $temp->format("%H:%M"),
                             'SELECTED' => $start_time && $start_time->equal($current) ? "selected='selected'" : ""));
    $current->add($timeslot);
  }
  $template->addRows("start_time", $times);
  
  // get list of event_ratings
  $rating = new Event_Rating;
  if ($rating->select(array('event_id' => $event->get('event_id'), 'remark' => true))) {
    $ratings = array();
    $rater = new View_Person;
    foreach($rating as $key){
      $rater->select(array('person_id' => $rating->get('person_id')));
      array_push($ratings, array(
          'URL'       => get_person_url($rater),
          'IMAGE_URL' => get_person_image_url($rater),
          'NAME'      => $rater->get('name'),
          'OPINION'   => $rating->get('remark')
        ));
    }
    $template->addRows("opinions", $ratings);
  }

  // get list of public event_ratings
  $rating = new Event_Rating_Public;
  if ($rating->select(array('event_id' => $event->get('event_id'), 'remark' => true))) {
    $ratings = array();
    foreach($rating as $key){
      array_push($ratings, array(
          'OPINION'   => $rating->get('remark')
        ));
    }
    $template->addRows("feedback", $ratings);
  }

  // get list of related events 
  $related = new Event_Related();
  $related->select(array('event_id1' => $event->get('event_id')));
  $ids = array();
  foreach ($related as $key) $ids[] = $related->get('event_id2');
  $related = new Event;
  $related->select(array('event_id' => $ids));
  $related_events = array();
  $event_person = new Event_Person;
  $event_role = new Event_Role;
  $person = new View_Person;
  $room = new Room;
  $track = new Conference_Track;
  $state = new Event_State_Localized;
  foreach( $related as $key) {
    
    $event_person->select(array('event_id' => $related->get('event_id')));
    $persons = array();
    $person_url = array();
    foreach($event_person as $value) {
      $event_role->select(array('event_role_id' => $event_person->get('event_role_id')));
      if ($event_role->get('tag') != "speaker" && $event_role->get('tag') != "moderator") continue;
      $person->select(array('person_id' => $event_person->get('person_id')));
      array_push($persons, $person->get('name'));
      array_push($person_url, get_person_url($person));
    }

    // is the event watched  
    $person_watchlist_event = new View_Watchlist_Event;
    if ($person_watchlist_event->select( array('person_id' => $related->get_auth_person_id(), 'event_id' => $related->get('event_id')))) {
      $watch = $GLOBAL_TEXT_WATCHED; 
    } else {
      $watch = $GLOBAL_TEXT_UNWATCHED;
    }
    $related_events[] = array( 'URL'   => get_event_url($related),
                        'EVENT_ID'     => $related->get('event_id'),
                        'IMAGE_URL'    => get_event_image_url($related),
                        'TITLE'        => $related->get('title'),
                        'SUBTITLE'     => $related->get('subtitle'),
                        'STATUS'       => $state->select(array('event_state_id' => $related->get('event_state_id'), 'language_id' => $related->get_language_id())) ? $state->get('name') : '',
                        'TRACK'        => $related->get('conference_track_id') && $track->select(array('conference_track_id' => $related->get('conference_track_id')))? $track->get('tag') : '' ,
                        'ROOM'         => $related->get('room_id') != 0 && $room->select(array('room_id'=>$related->get('room_id'))) ? $room->get('short_name') : '',
                        'DAY'          => $related->get('day'), 
                        'TIME'         => is_object( $related->get('start_time') ) ? $related->get('start_time')->format('%H:%M') : '',
                        'PERSON'       => $persons,
                        'PERSON_URL'   => $person_url, 
                        'WATCH_BUTTON' => $watch);
  }
  $template->addRows('related-list', $related_events);

  // get list of related events with matching keywords
  $related = new Related_Event_Keyword();
  $related->select(array('event_id'    => $event->get('event_id')));
  $related_events = array();
  $event_person = new Event_Person;
  $event_role = new Event_Role;
  $person = new View_Person;
  foreach( $related as $key) {
    
    $event_person->select(array('event_id' => $related->get('event_id')));
    $persons = array();
    $person_url = array();
    foreach($event_person as $value) {
      $event_role->select(array('event_role_id' => $event_person->get('event_role_id')));
      if ($event_role->get('tag') != "speaker" && $event_role->get('tag') != "moderator") continue;
      $person->select(array('person_id' => $event_person->get('person_id')));
      array_push($persons, $person->get('name'));
      array_push($person_url, get_person_url($person));
    }

    // is the event watched  
    $person_watchlist_event = new View_Watchlist_Event;
    if ($person_watchlist_event->select( array('person_id' => $related->get_auth_person_id(), 'event_id' => $related->get('event_id')))) {
      $watch = $GLOBAL_TEXT_WATCHED; 
    } else {
      $watch = $GLOBAL_TEXT_UNWATCHED;
    }
    $related_events[] = array( 'URL'   => get_event_url($related),
                        'EVENT_ID'     => $related->get('event_id'),
                        'IMAGE_URL'    => get_event_image_url($related),
                        'TITLE'        => $related->get('title'),
                        'SUBTITLE'     => $related->get('subtitle'),
                        'STATUS'       => $state->select(array('event_state_id' => $related->get('event_state_id'), 'language_id' => $related->get_language_id())) ? $state->get('name') : '',
                        'TRACK'        => $related->get('conference_track_id') && $track->select(array('conference_track_id' => $related->get('conference_track_id')))? $track->get('tag') : '' ,
                        'ROOM'         => $related->get('room_id') != 0 && $room->select(array('room_id'=>$related->get('room_id'))) ? $room->get('short_name') : '',
                        'DAY'          => $related->get('day'), 
                        'TIME'         => is_object( $related->get('start_time') ) ? $related->get('start_time')->format('%H:%M') : '',
                        'PERSON'       => $persons,
                        'PERSON_URL'   => $person_url, 
                        'WATCH_BUTTON' => $watch);
  }
  $template->addRows('related-keyword-list', $related_events);

  // get list of related events with identical speaker
  $related = new Related_Event_Speaker();
  $related->select(array('event_id' => $event->get('event_id')));
  $related_events = array();
  foreach( $related as $key) {

    $event_person->select(array('event_id' => $related->get('event_id')));
    $persons = array();
    $person_url = array();
    foreach($event_person as $value) {
      $event_role->select(array('event_role_id' => $event_person->get('event_role_id')));
      if ($event_role->get('tag') != "speaker" && $event_role->get('tag') != "moderator") continue;
      $person->select(array('person_id' => $event_person->get('person_id')));
      array_push($persons, $person->get('name'));
      array_push($person_url, get_person_url($person));
    }

    // is the event watched  
    $person_watchlist_event = new View_Watchlist_Event;
    if ($person_watchlist_event->select( array('person_id' => $related->get_auth_person_id(), 'event_id' => $related->get('event_id')))) {
      $watch = $GLOBAL_TEXT_WATCHED; 
    } else {
      $watch = $GLOBAL_TEXT_UNWATCHED;
    }
    $related_events[] = array( 'URL'   => get_event_url($related),
                        'EVENT_ID'     => $related->get('event_id'),
                        'IMAGE_URL'    => get_event_image_url($related),
                        'TITLE'        => $related->get('title'),
                        'SUBTITLE'     => $related->get('subtitle'),
                        'STATUS'       => $state->select(array('event_state_id' => $related->get('event_state_id'), 'language_id' => $related->get_language_id())) ? $state->get('name') : '',
                        'TRACK'        => $related->get('conference_track_id') && $track->select(array('conference_track_id' => $related->get('conference_track_id')))? $track->get('tag') : '' ,
                        'ROOM'         => $related->get('room_id') != 0 && $room->select(array('room_id'=>$related->get('room_id'))) ? $room->get('short_name') : '',
                        'DAY'          => $related->get('day'), 
                        'TIME'         => is_object($related->get('start_time')) ? $related->get('start_time')->format('%H:%M') : '',
                        'PERSON'       => $persons,
                        'PERSON_URL'   => $person_url, 
                        'WATCH_BUTTON' => $watch);
  }
  $template->addRows('related-speaker-list', $related_events);

  
?>
