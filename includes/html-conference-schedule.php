<?php

  require_once("../db/view_fahrplan_event.php");
  require_once("../db/view_event_person_person.php");
  require_once("../db/view_fahrplan_person.php");
  require_once("../db/view_person.php");
  require_once("../db/event_type_localized.php");
  require_once("../db/conference_track.php");

  $template->readTemplatesFromFile("html-schedule.tmpl");

  $day = (integer) substr($OPTIONS[0],4,1);
  $lang = substr($OPTIONS[0],6,2);
 
  $template->addVar('main', 'TITLE', "{$conference->get("acronym")}: Schedule Day {$day}");
  $template->addVar('main', 'DOC_NAME', "day_{$day}");

  $template->addVar('content', 'DAY', "{$day}");

  class Assignment
  {
    public $conflict = false;
    public $slots = 0;
    public $event_id = 0;
    public $title = "";
    public $subtitle ="";
    public $abstract = "";
    public $type = "";
    public $track = "";
    public $language = "";
    public $speaker = array();
  }

  class Speaker
  {
    public $person_id = 0;
    public $name = "";
  }

  class Conflict
  {
    public $slots = 0;
    public $events = array();
  }

  $timeslot_duration = $conference->get("timeslot_duration");
  
  $room = new Room;
  $room->select(array("conference_id" => $conference->get("conference_id") ));
  
  $event = new View_Fahrplan_Event;
  $event->select(array('conference_id' =>$conference->get("conference_id"), 'day' => $day, 'f_public' => 't'));

  $time_table = array();
  $first_slot = null;
  $last_slot = null;
  $event_person = new View_Fahrplan_Person;
  $person = new View_Person;
  $language = new Language_Localized;
  $language->select( array("language_id" => $sprache->get("language_id")));
  $languages[""] = "";
  foreach($language as $value) $languages[$language->get("translated_id")] = $language->get("name");
  
  $track = new Conference_Track;
  $track->select(array("conference_id" => $conference->get("conference_id")));
  $tracks[""] = "";
  foreach($track as $value) $tracks[$track->get("conference_track_id")] = $track->get("tag");

  $type = new Event_Type_Localized;
  $type->select(array("language_id" => $sprache->get("language_id")));
  $types[""] = "";
  foreach($type as $value) $types[$type->get("event_type_id")] = $type->get("name");

  foreach($event as $value) {
    $current = new Assignment;
    $event_slot = $event->get("relative_start_time")->toSeconds()/$timeslot_duration->toSeconds();
    $event_duration = $event->get("duration");
    $event_slots = $event_duration->toSeconds()/$timeslot_duration->toSeconds();
    $speakers = array();
    $event_person->select(array('event_role_tag' => array('speaker', 'moderator'), 'event_id' => $event->get("event_id")));
    foreach($event_person as $value) {
      $speaker = new Speaker;
      $person->select( array("person_id" => $event_person->get("person_id")));
      $speaker->person_id = $person->get("person_id");
      $speaker->name = $person->get("name");
      array_push($speakers, $speaker);
    }
    
    if (isset($time_table[$event->get("room_id")][$event_slot])) {
      // we've got a conflict
      $current->conflict = true;
      for ($i = $event_slot; $i >= $first_slot && !($time_table[$event->get("room_id")][$i] instanceof Assignment);$i--);
      $old = $time_table[$event->get("room_id")][$i];
      $event_slots = $old->slots < ($event_slot - $i + $event_slots) ? $event_slot - $i + $event_slots : $old->slots;
      $event_slot = $i;
      if (is_array($old->event_id)) {
        array_push($old->event_id, $event->get("event_id"));
        array_push($old->title, htmlspecialchars($event->get("title")));
        array_push($old->subtitle, htmlspecialchars($event->get("subtitle")));
        array_push($old->abstract, htmlspecialchars($event->get("abstract")));
        array_push($old->language, $languages[$event->get("language_id")]);
        array_push($old->speaker, $speakers);
        $current->event_id = $old->event_id;
        $current->title    = $old->title;
        $current->subtitle = $old->subtitle;
        $current->abstract = $old->abstract;
        $current->language = $old->language;
        $current->speaker  = $old->speaker;
      } else {
        $current->event_id = array($old->event_id, $event->get("event_id"));
        $current->title = array($old->title, htmlspecialchars($event->get("title")));
        $current->subtitle = array($old->subtitle, htmlspecialchars($event->get("subtitle")));
        $current->abstract = array($old->abstract, htmlspecialchars($event->get("abstract")));
        $current->language = array($old->language, $languages[$event->get("language_id")]);
        $current->speaker = array($old->speaker, $speakers);
      }
      
    } else { 
      // everything is fine
      $current->event_id = $event->get("event_id");
      $current->title = htmlspecialchars($event->get("title"));
      $current->subtitle = htmlspecialchars($event->get("subtitle"));
      $current->abstract = htmlspecialchars($event->get("abstract"));
      $current->type = $types[$event->get("event_type_id")];
      $current->track = $tracks[$event->get("conference_track_id")];
      $current->language = $languages[$event->get("language_id")];
      $current->speaker = $speakers;
    }
    $current->slots = $event_slots;
    $time_table[$event->get("room_id")][$event_slot] = $current;
    for ($i = 1; $i < $event_slots; $i++) {
      $time_table[$event->get("room_id")][$event_slot + $i] = false;
    }
    $first_slot = isset($first_slot) ? ($first_slot < $event_slot ? $first_slot : $event_slot) : $event_slot;
    $last_slot = isset($last_slot) ? ($last_slot > ($event_slot + $event_slots - 1 ) ? $last_slot : $event_slot + $event_slots - 1) : ($event_slot + $event_slots - 1);
  
  }

  $rooms = array();
  foreach($room as $value){
    array_push($rooms, array('ROOM' => $room->get('short_name')));
  }
  $template->addRows('room', $rooms);

  $current_time = $conference->get("day_change");
  $schedule = array();
  for($i = 1; $i < $first_slot; $i++) $current_time->add($conference->get('timeslot_duration')); 
  
  for($row = $first_slot; $row <= $last_slot; $row++) {
    $index = count($schedule);

    $current_time->add($conference->get('timeslot_duration')); 
    
    $schedule[$index]['TIME'] = $current_time->format('%H:%M');
    
    
    $types = array();
    $rowspan = array();
    $event_ids = array();
    foreach($room as $value) {
      if (!(isset($time_table[$room->get('room_id')][$row]))) {
        // empty field
        $schedule[$index]['TYPE'][$value] = '';
        $current = new Assignment;
      } else if($time_table[$room->get('room_id')][$row] === false) {
        // nothing to do
        $schedule[$index]['TYPE'][$value] = 'empty';
        $current = new Assignment;
      } else {
        // event taking place
        $schedule[$index]['TYPE'][$value] = 'event';
        $current = $time_table[$room->get("room_id")][$row];
      }
      $schedule[$index]['ROWSPAN'][$value] = $current->slots;
      $schedule[$index]['EVENT_ID'][$value] = $current->event_id;
      $schedule[$index]['EVENT_URL'][$value] = "event/{$current->event_id}.$lang.html";
      $schedule[$index]['EVENT_TITLE'][$value] = $current->title;
      $schedule[$index]['EVENT_SUBTITLE'][$value] = $current->subtitle;
      $schedule[$index]['EVENT_TYPE'][$value] = $current->type;
      $schedule[$index]['EVENT_TRACK'][$value] = $current->track;
      $schedule[$index]['EVENT_LANGUAGE'][$value] = $current->language;
      $schedule[$index]['EVENT_ABSTRACT'][$value] = $current->abstract;

      $schedule[$index]['SPEAKER_URL'][$value] = array();
      $schedule[$index]['SPEAKER_NAME'][$value] = array();
      foreach($current->speaker as $key => $name) {
        $schedule[$index]['SPEAKER_URL'][$value][$key] = "speaker/{$name->person_id}.$lang.html";
        $schedule[$index]['SPEAKER_NAME'][$value][$key] = $name->name;
      }
    }

  }

  $template->addRows('schedule', $schedule);
  $template->displayParsedTemplate('main');

?>
