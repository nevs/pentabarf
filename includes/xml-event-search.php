<?php

  require_once('../db/conference.php');
  require_once('../db/room.php');
  require_once('../db/event.php');
  require_once('../db/find_event.php');
  require_once('../db/event_type.php');
  require_once('../db/view_person.php');
  require_once('../db/language.php');
  require_once('../db/event_person.php');
  require_once('../db/event_role.php');
  require_once('../db/conference_track.php');
  require_once('../db/event_image.php');
  require_once('../db/person_image.php');
  require_once('../db/mime_type.php');
  require_once('../db/event_state.php');
  require_once('../db/room.php');
  require_once('Date.php');

  
  $conference = new Conference;
  $conference->select(array('conference_id' => $preferences['conference']));
  $date = new Date;
  
  header("Content-Type: text/xml");

echo <<<END
<?xml version="1.0" encoding="utf-8" ?>

  <search-result>

    <!-- events -->
    <events>

END;

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

$language = new Language;
$event_person = new Event_Person;
$event_role = new Event_Role;
$time_slot = new Date_Span($conference->get('timeslot_duration', '%H:%M:%S'));
$event_length = new Date_Span;
$track = new Conference_Track;
$e_image = new Event_Image;
$mime_type = new Mime_Type;
$event_type = new Event_Type;
$persons = array();
$event_state = new Event_State;
$room = new Room;

foreach($event as $value)
{
  $lang = $language->select(array( 'language_id' => $event->get('language_id'))) ? $language->get('tag') : "";
  $event_length->set($event->get('duration'),'%H:%M:%S');
  $slots = $event_length->toSeconds()/$time_slot->toSeconds();
  $c_track = $track->select(array( 'conference_track_id' => $event->get('conference_track_id'))) ? xmlentities($track->get('tag')) : "";
  $type = $event_type->select(array( 'event_type_id' => $event->get('event_type_id'))) ? xmlentities($event_type->get('tag')) : "";

  $event_start = new Date($conference->get('start_date')->format('%Y-%m-%d'));
  $event_start->addSpan($event->get('start_time'));
  $title = xmlentities($event->get('title'));
  $subtitle = xmlentities($event->get('subtitle'));
  $event_duration = $event->get('duration')->format('%H:%M');
  $event_state->select(array('event_state_id' => $event->get('event_state_id')));
  $state = xmlentities($event_state->get('tag'));
  $e_room = $room->select(array('room_id' => $event->get('room_id'))) ? xmlentities($room->get('short_name')) : "";
  $start = $event->get('start_time') ? $event_start->format('%Y-%m-%dT%H:%M') : ""; 

echo <<<END

      <event start="{$start}" room="{$e_room}" duration="{$event_duration}" slots="{$slots}">
        <id>{$event->get('event_id')}</id>
        <title>{$title}</title>
        <subtitle>{$subtitle}</subtitle>
        <event-type>{$type}</event-type>
        <event-state>{$state}</event-state>
        <track>{$c_track}</track>
        <language>{$lang}</language>
END;

$event_person->select(array('event_id' => $event->get('event_id')));
foreach($event_person as $value)
{
  $event_role->select(array('event_role_id' => $event_person->get('event_role_id')));
  if ($event_role->get('tag') != 'speaker' && $event_role->get('tag') != 'moderator') continue;
  if (!in_array($event_person->get('person_id'), $persons)) {
    array_push($persons, $event_person->get('person_id'));
  }
echo <<<END
  
        <person role="{$event_role->get('tag')}" person-id="{$event_person->get('person_id')}" />
END;
}
$abstract =  xmlentities($event->get('abstract'));
$description =  str_replace(array("\r", "\n"), "", nl2br(xmlentities($event->get('description'))));
echo <<<END

        <abstract>{$abstract}</abstract>
        <description>
          <body xmlns="http://www.w3.org/1999/xhtml">{$description}</body>
        </description>
END;

if ($e_image->select(array('event_id' => $event->get('event_id'))))
{
  $mime_type->select(array('mime_type_id' => $e_image->get('mime_type_id')));
  $image_data = base64_encode($e_image->get('image'));
echo <<<END

        <image mime-type="{$mime_type->get('mime_type')}" content-encoding="base64">{$image_data}</image>
END;
}

echo <<<END

      </event>
END;
}
echo <<<END

    </events>

    <!-- persons -->

    <persons>

END;


$person = new View_Person;
$person->select(array('person_id' => $persons ));

foreach($person as $value)
{
  $name = xmlentities($person->get('name'));
  $email = xmlentities($person->get('email_public'));
  $bio = xmlentities($person->get('description'));
echo <<<END

      <person>
        <id>{$person->get('person_id')}</id>
        <public-name>{$name}</public-name>
        <email>{$email}</email>
        <bio>{$bio}</bio>
      </person>

END;
}

echo <<<END

    </persons>
  </search-result>
END;

?>
