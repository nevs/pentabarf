<?php

  require_once("../functions/error_handler.php");
  require_once("../db/auth_person.php");

  $auth_person = new Auth_Person;

  // put URL parts in $VIEW, $RESOURCE and $OPTIONS
  $BASE_URL = str_replace("html2.php","",$_SERVER['SCRIPT_NAME']);
  $OPTIONS = explode("/",$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);

  $views = array("conference");

  if (in_array($VIEW, $views)) {
    require_once("../includes/html2-$VIEW.php");
  } else {
    trigger_error("404 in html.php");
    require_once("error.html");
    exit;
  }

?>
