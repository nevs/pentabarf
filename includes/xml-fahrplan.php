<?php
  
  require_once('../db/conference.php');
  require_once('../db/room.php');
  require_once('../db/event.php');
  require_once('../db/event_type.php');
  require_once('../db/person.php');
  require_once('../db/language.php');
  require_once('../db/event_person.php');
  require_once('../db/event_role.php');
  require_once('../db/conference_track.php');
  require_once('../db/event_image.php');
  require_once('../db/mime_type.php');
  require_once('../db/event_role_state.php');
  require_once('../db/view_fahrplan_event.php');
  require_once('../db/view_fahrplan_person.php');
  require_once('Date.php');


  if ($RESOURCE != "conference" || !isset($OPTIONS[0])) {
    trigger_error("404 in XML-Export");
    require_once('../wwwroot/error.html');
    exit;
  }

  if (isset($OPTIONS[1]) && $OPTIONS[1] == "with_images") {
    $with_images = true;
  } else {
    $with_images = false;
  }

  header("Content-Type: text/xml");
  
  $conference = new Conference;
  $conference->select(array('conference_id' => $OPTIONS[0]));
  $date = new Date;
  $title = xmlentities($conference->get('title'));
  $subtitle = xmlentities($conference->get('subtitle'));
  $acronym = xmlentities($conference->get('acronym'));
  $duration = $conference->get('timeslot_duration')->format('%H:%M');
  $day_change = $conference->get('day_change');
  
echo <<<END
<?xml version="1.0" encoding="utf-8" ?>
<fahrplan version="{$conference->get('release')}" xmlns="http://pentabarf.org/fahrplan/" xmlns:xhtml="http://www.w3.org/1999/xhtml" xml:lang="de">

  <release>{$conference->get('release')}</release>
  <release-date>{$date->format('%Y-%m-%dT%H:%M:%S')}</release-date>

  <!--  conference meta data  -->
  <conference>
    <id>{$conference->get('conference_id')}</id>
    <title>{$title}</title>
    <subtitle>{$subtitle}</subtitle>
    <acronym>{$acronym}</acronym>
    <slot-duration>{$duration}</slot-duration>
    <day-change>{$day_change->format('%H:%M')}</day-change>
  </conference>

  <!-- conference rooms -->

  <rooms>
END;

$room = new Room;
$room->select(array('conference_id' => $conference->get('conference_id')));

foreach ($room as $value) {
  $room_name = xmlentities($room->get('short_name'));
echo <<<END

    <room>
      <id>{$room->get('room_id')}</id>
      <number>{$room->get('rank')}</number>
      <name>{$room_name}</name>
    </room>
  
END;
}
echo <<<END

  </rooms>

  <!-- events -->

  <events>

END;

$event = new View_Fahrplan_Event;
$event->select(array('conference_id' => $conference->get('conference_id'), 'f_public' => 't'));
$language = new Language;
$event_person = new View_Fahrplan_Person;
$event_role = new Event_Role;
$time_slot = $conference->get('timeslot_duration');
$event_length = new Date_Span;
$track = new Conference_Track;
$event_type = new Event_Type;
$e_image = new Event_Image;
$mime_type = new Mime_Type;

foreach($event as $value)
{
  $language->select(array('language_id' => $event->get('language_id')));
  $event_length = $event->get('duration');
  $slots = $event_length->toSeconds()/$time_slot->toSeconds();
  if ( $track->select(array('conference_track_id' => $event->get('conference_track_id'))) ) {
     $c_track = xmlentities($track->get('tag'));
  } else { $c_track = '';
  }
  $event_type->select(array('event_type_id' => $event->get('event_type_id')));
  $event_start = $event->get('start_datetime');
  $title = xmlentities($event->get('title'));
  $subtitle = xmlentities($event->get('subtitle'));
  $type = xmlentities($event_type->get('tag'));
  $duration = $event->get('duration')->format('%H:%M');
  $dur_parts = explode(":",$duration);
  $event_role_state = new Event_Role_State;
echo <<<END

    <event start="{$event_start->format('%Y-%m-%dT%H:%M')}" year="{$event_start->format('%Y')}" month="{$event_start->format('%m')}" day="{$event_start->format('%d')}" day-no="{$event->get('day')}" time="{$event_start->format('%H%M')}" duration="{$duration}" hours="{$dur_parts[0]}" minutes="{$dur_parts[1]}" slots="{$slots}" room-id="{$event->get('room_id')}">
      <id>{$event->get('event_id')}</id>
      <title>{$title}</title>
      <subtitle>{$subtitle}</subtitle>
      <event-type>{$type}</event-type>
      <track>{$c_track}</track>
      <language>{$language->get('tag')}</language>
END;

$event_person->select(array('event_id' => $event->get('event_id')));
foreach($event_person as $value)
{
//  $event_role->select(array('event_role_id' => $event_person->get('event_role_id')));
//  if ($event_role->get('tag') != 'speaker' && $event_role->get('tag') != 'moderator') continue;
//  $event_role_state->select(array('event_role_state_id' => $event_person->get('event_role_state_id')));
//  if ($event_role_state->get('tag') != 'confirmed') continue;
echo <<<END
  
      <person role="{$event_person->get('event_role_tag')}" person-id="{$event_person->get('person_id')}" />
END;
}
$description = str_replace(array("\r", "\n"), "", nl2br(xmlentities($event->get('description'))));
$abstract = xmlentities($event->get('abstract'));

echo <<<END

      <abstract>{$abstract}</abstract>
      <description>
        <body xmlns="http://www.w3.org/1999/xhtml">{$description}</body>
      </description>
END;

if ($with_images && $e_image->select(array('event_id' => $event->get('event_id'))))
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

$person = new View_Fahrplan_Person;
$person->select(array('conference_id' => $conference->get('conference_id')));

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

  <!-- the actual schedule sorted by days and rooms -->

  <schedule>
END;

$date = $conference->get('start_date');

for ($i = 1; $i <= $conference->get('days'); $i++)
{
echo <<<END

    <day date="{$date->format('%Y-%m-%d')}">
END;

foreach ($room as $value)
{
echo <<<END

      <room room-id="{$room->get('room_id')}">
END;

$event = new View_Fahrplan_Event;
$event->select(array('conference_id' => $conference->get('conference_id'), 'day' => $i, 'room_id' => $room->get('room_id'), 'f_public' => 't'));
foreach ($event as $value)
{
  $e_duration = $event->get('duration')->format('%H:%M');
echo <<<END

        <slot time="{$event->get('start_time')->format('%H:%M')}" duration="{$e_duration}" event-id="{$event->get('event_id')}" />
END;
}
echo <<<END

      </room>
END;
}
echo <<<END

    </day>
END;
$date = $date->getNextDay();
}
echo <<<END

END;

echo <<<END

  </schedule>

</fahrplan>

END;

?>
