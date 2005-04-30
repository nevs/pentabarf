<?php

  require_once("../functions/error_handler.php");
  require_once("../db/auth_person.php");
  require_once("../db/mime_type.php");

  $auth_person = new Auth_Person;

  // put URL parts in $VIEW, $RESOURCE and $OPTIONS
  $OPTIONS = explode("/",$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);

  $BASE_URL = str_replace("attachment.php","",$_SERVER['SCRIPT_NAME']);
  
  $sizes = array("32x32", "16x16", "64x64", "128x128");
  
  switch($VIEW)
  {
    case "event":
      require_once("../db/view_event_attachment.php");
      $class = new View_Event_Attachment;
      break;
    default:
      exit;
  }
  
  if ($class->select(array($VIEW.'_attachment_id' => $RESOURCE)))
  {

    $type = new Mime_Type;
    $type->select(array('mime_type_id' => $class->get('mime_type_id')));

    header("Content-Type: ".$type->get('mime_type')); 
    header("Content-Length: ".$class->get('filesize')); 
    echo $class->get('data');
  
  } else {
    throw new Exception("there is no attachment with this id",1);
  }

?>
