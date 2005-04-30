<?php

  require_once('../functions/error_handler.php');
  require_once('../db/auth_person.php');
  require_once('../db/view_fahrplan_person.php');
  require_once('../db/view_event_person.php');
  require_once('../db/view_event.php');
  new Auth_Person;

  // put URL parts in $VIEW, $RESOURCE and $OPTIONS
  $OPTIONS = explode("/",$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);

  $cond = array('conference_id' => 1); 
  switch($VIEW) {
    case 'speaker':
    case 'moderator':
      $cond['event_role_tag'] = $VIEW;
      break;
    default:
  }
  
  $speaker = new View_Fahrplan_Person($cond);
  $event_person = new View_Event_Person;

  $done = array();
  foreach($speaker as $key) {
    if (!$speaker->get('email_contact')) continue;
    if (in_array($speaker->get('person_id'), $done)) continue;
    array_push($done, $speaker->get('person_id'));
    echo (($speaker->get('first_name') && $speaker->get('last_name')) ? $speaker->get('first_name')." ".$speaker->get('last_name') : $speaker->get('name'))." <".$speaker->get('email_contact').">\r\n<br/>";
    $event_person->select('person_id' => $speaker->get('person_id'), 'conference_id' => 1);
    
  }
  
?>
