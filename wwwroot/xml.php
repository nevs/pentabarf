<?php

  require_once('../functions/error_handler.php');
  require_once('../db/auth_person.php');
  require_once('../functions/xml-functions.php');

  // authenticate Person
  $auth_person = new Auth_Person;
  $preferences = $auth_person->get('preferences');

  // put URL parts in $VIEW, $RESOURCE and $OPTIONS
  $OPTIONS = explode("/",$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);

  $exports = array("fahrplan", "event-search");

  if (!in_array($VIEW, $exports)) {
    trigger_error("404 in XML-Export");
    require_once('../wwwroot/error.html');
    exit;
  } else {
    require_once("../includes/xml-$VIEW.php");
  }
  

?>
