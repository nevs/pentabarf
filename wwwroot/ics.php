<?php
  
  require_once('../functions/error_handler.php');
  require_once('../db/view_fahrplan_event.php');
  require_once('../db/view_event_person_with_role_state.php');
  require_once('../db/auth_person.php');
  require_once('../db/conference.php');
  require_once('../db/time_zone.php');
  new Auth_Person;

  $OPTIONS = explode("/",$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);
  
  if ($VIEW != 'conference') {
    throw new Exception('404 in ics.php');
  }

// constants: should be replaced by URL parameters

  $conference_timezone = 'Europe/Berlin';

// functions

function escape($string)
{
  return str_replace(array("\n","\r", ";", ","), array("\\n", "", "\\;", "\\,"), $string);
}

function fold($string)
{
  $MAX_OCTETS = 74;
  
  $output = "";
  while(strlen($string) > $MAX_OCTETS) {
    $output .= substr($string, 0, $MAX_OCTETS)."\r\n ";
    $string = substr($string, $MAX_OCTETS);
  }
  $output .= $string . "\r\n";
  return $output;
}


// export fahrplan as iCalendar

  $conference = new Conference;
  $conference->select( array ("conference_id" => $RESOURCE) );
  
  $conference_acronym = $conference->get("acronym");
  $conference_title = $conference->get("title");
  $conference_release = $conference->get("release");

  $fahrplan = new View_Fahrplan_Event(array('conference_id' => $conference->get('conference_id'), 'f_public' => 't'));

  header("Content-type: text/calendar"); 
  header("Content-Disposition: inline; filename=\"fahrplan.ics\""); 
  
  echo fold("BEGIN:VCALENDAR");
  echo fold("VERSION:2.0");
  echo fold("PRODID:-//Pentabarf//Fahrplan 0.3//EN");
  echo fold("CALSCALE:GREGORIAN");
  echo fold("METHOD:PUBLISH");
  echo fold("X-WR-CALDESC;VALUE=TEXT:{$conference_acronym} Fahrplan Release {$conference_release}");
  echo fold("X-WR-CALNAME;VALUE=TEXT:{$conference_acronym} Fahrplan");
  echo fold("X-WR-TIMEZONE;VALUE=TEXT:{$conference_timezone}");


  foreach($fahrplan as $v) {
    $event_id = $fahrplan->get('event_id');
    $room = $fahrplan->get('room');
    $title = $fahrplan->get('title');
    $subtitle = $fahrplan->get('subtitle');
    $abstract = $fahrplan->get('abstract');
    $description = $fahrplan->get('description');

    $persons = new View_Event_Person_with_Role_State;
    $persons->select( array("event_id" => $event_id, "event_role_state_tag" => "confirmed", "event_role_tag" => array ("speaker", "moderator") ) );
  
    // construct VEVENT DTSTART
  
    $start_date = $fahrplan->get("start_datetime");
    $vevent_dtstart = $start_date->format("%Y%m%d") . $fahrplan->get("start_time")->format("T%H%M%S") ;
    
    // construct VEVENT DURATION
  
    $vevent_duration = "";
    if ($fahrplan->get("duration")->hour) {
      $vevent_duration = $fahrplan->get("duration")->format('%hH');
    }

    if ($fahrplan->get("duration")->minute) {
      $vevent_duration .= $fahrplan->get("duration")->format('%MM');
    }

    // construct VEVENT SUMMARY

    $vevent_summary = escape($title);

    // construct VEVENT DESCRIPTION

    $vevent_description = escape($title . "\r\n");
    if ($subtitle) {
      $vevent_description .= escape($subtitle . "\r\n");
    }
    $vevent_description .= escape("\r\n");

    foreach($persons as $index) {
      if ($index > 0) {
        $vevent_description .= escape(", ");
      }
      $vevent_description .= escape($persons->get("name"));
    }
    $vevent_description .= escape("\r\n\r\n");
  
    if ($abstract) {
      $vevent_description .= escape ($abstract . "\r\n");
    }

/*
    if ($description) {
      $vevent_description .= escape ($description . "\r\n");
    }
*/

    // generate vevent record
  
    echo fold("BEGIN:VEVENT");
    echo fold("METHOD:PUBLISH");
    echo fold("UID:{$event_id}@{$conference_acronym}@pentabarf.org");
    echo fold("DTSTART;TZID={$conference_timezone}:{$vevent_dtstart}");
    echo fold("DURATION:PT{$vevent_duration}");
    echo fold("SUMMARY:{$vevent_summary}");
    echo fold("DESCRIPTION:{$vevent_description}");
    echo fold("CLASS:PUBLIC");
    echo fold("STATUS:CONFIRMED");

    foreach($persons as $index) {
      $email_public = $persons->get("email_public");
      $name = str_replace("\"", "'", $persons->get("name"));
      echo fold("ATTENDEE;ROLE=REQ-PARTICIPANT;CUTYPE=INDIVIDUAL;CN=\"{$name}\":" . ($email_public ? "mailto:{$email_public}" : "invalid:nomail") . "");
    }
  
    echo fold("CATEGORY:Lecture");
    echo fold("URL:{$conference->get('export_base_url')}event/{$event_id}.html");
    echo fold("LOCATION:{$room}");
    echo fold("END:VEVENT");
  
  }

  echo fold("END:VCALENDAR");
?>
