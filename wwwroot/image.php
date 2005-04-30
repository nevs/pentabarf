<?php

  require_once("../functions/error_handler.php");
  require_once("../db/auth_person.php");
  require_once("../db/mime_type.php");

  $auth_person = new Auth_Person;

  // put URL parts in $VIEW, $RESOURCE and $OPTIONS
  $OPTIONS = explode("/",$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);
  

  $sizes = array("32x32", "16x16", "64x64", "128x128");
  
  switch($VIEW)
  {
    case "person":
      require_once("../db/person_image.php");
      $class = new Person_Image;
      break;
    case "event":
      require_once("../db/event_image.php");
      $class = new Event_Image;
      break;
    case "conference":
      require_once("../db/conference_image.php");
      $class = new Conference_Image;
      break;
    default:
      exit;
  }
  
  if ($RESOURCE && $class->select(array($VIEW."_id" => $RESOURCE)) == 1)
  {
    $type = new Mime_Type;
    $type->select(array('mime_type_id' => $class->get('mime_type_id')));

    header("Content-type: ".$type->get('mime_type')); 
    echo $class->get('image');
  
  } else {
    $size = isset($OPTIONS[0]) ? $sizes[array_search($OPTIONS[0], $sizes)] : $sizes[0];
    $BASE_URL = str_replace("image.php","",$_SERVER['SCRIPT_NAME']);
    header("Location: ".$BASE_URL."images/icon-".$VIEW."-".$size.".png");
    exit;
  }

?>
