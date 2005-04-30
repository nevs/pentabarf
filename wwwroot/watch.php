<?php

  require_once("../includes/globals.php");
  require_once("../functions/error_handler.php");
  require_once("../db/auth_person.php");
  

  // authenticate Person
  $auth_person = new Auth_Person;


  // put URL parts in $VIEW, $RESOURCE and $OPTIONS
  $OPTIONS = explode("/",$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);

  $views = array("conference", "event", "person");

  if (!in_array($VIEW, $views)){
    trigger_error("404 page not found.");
    exit;
  } else {
    require_once("../db/person_watchlist_$VIEW.php");
    switch($VIEW){
      case "conference":
        $class = new Person_Watchlist_Conference;
        $field_name = "conference_id";
        break;
      case "event":
        $class = new Person_Watchlist_Event;
        $field_name = "event_id";
        break;
      case "person":
        $class = new Person_Watchlist_Person;
        $field_name = "watched_person_id";
        break;
    }
    if ($class->select(array('person_id' => $class->get_auth_person_id(), $field_name => $RESOURCE))) {
      $class->delete();
      print($GLOBAL_TEXT_UNWATCHED);
      exit;
    } else {
      $class->create();
      $class->set('person_id', $class->get_auth_person_id());
      $class->set($field_name, $RESOURCE);
      $class->write();
      print($GLOBAL_TEXT_WATCHED);
      exit;
    }
  }
?>
