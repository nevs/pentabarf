<?php
  
  require_once("../db/conference.php");
  require_once("../db/view_event.php");
  require_once("../db/event_person.php");
  require_once("../db/view_person.php");
  require_once("../db/event_role.php");
  require_once("../db/room.php");
  require_once("../db/conference_track.php");
  require_once("Date.php");

  $conference = new Conference;
  $conference->select(array('conference_id' => $preferences['conference']));
  $date = $conference->get('start_date');

  $template->addVar("main","CONTENT_TITLE","Reports: Zeitplan");
  $template->addVar("main","VIEW_TITLE", "Reports");

  $event = new View_Event;
  $event->set_order("event.day, event.start_time");
  $room = new Room;
  $room->select(array('conference_id' => $preferences['conference']));
  $track = new Conference_Track;
  $track->select(array('conference_id' => $preferences['conference']));
  $tracks = array();
  $tracks[""] = "";
  foreach($track as $value) { $tracks[$track->get('conference_track_id')] = $track->get('tag'); }
  $schedule = array();
  $event_person = new Event_Person;
  $event_role = new Event_Role;
  $person = new View_Person;

  for ($i = 1; $i <= $conference->get('days'); $i++)
  {
    foreach($room as $value) {
      $event->select(array('conference_id' => $conference->get('conference_id'), 'day' => $i, 'room_id' => $room->get('room_id')));
      $append = array();
      foreach($event as $value) {
        $event_person->select(array('event_id' => $event->get('event_id')));
        $persons = array();
        $person_url = array();
        foreach($event_person as $value) {
          $event_role->select(array('event_role_id' => $event_person->get('event_role_id')));
          if ($event_role->get('tag') != "speaker" && $event_role->get('tag') != "moderator") continue;
          $person->select(array('person_id' => $event_person->get('person_id')));
          array_push($persons, $person->get('name'));
          array_push($person_url, get_person_url($person));
        }
        $event_data = array('URL'         => get_event_url($event),
                            'IMAGE_URL'   => get_event_image_url($event),
                            'DAY'         => $event->get('day'),
                            'ROOM'        => $room->get('short_name'),
                            'TRACK'       => $tracks[$event->get('conference_track_id')],
                            'TIME'        => $event->get('real_start_time')->format('%H:%M:%S'),
                            'DURATION'    => $event->get('duration')->format('%H:%M'),
                            'TITLE'       => $event->get('title'),
                            'SUBTITLE'    => $event->get('subtitle'),
                            'STATE'       => $event->get('event_state'),
                            'PUBLIC'      => $event->get('f_public') == 't' ? "yes" : "no",
                            'PERSON'      => $persons,
                            'PERSON_URL'  => $person_url
                            );
        array_push($schedule, $event_data);
/*        if ($event->get('start_time')->format('%H:%M:%S') < $conference->get('day_change')->format('%H:%M:%S')) {
          array_push($append, $event_data);
        } else {
          array_push($schedule, $event_data);
        }*/
      }
/*      foreach($append as $value) {
        array_push($schedule, $value);
      }*/
    }
  }
  
  $template->addRows('schedule', $schedule);
    
?>
