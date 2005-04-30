<?php

  require_once('../db/conference.php');
  require_once('../db/event.php');
  require_once('../db/person.php');
  require_once('../db/view_watchlist_person.php');
  


  /** Function for getting the URL to an Object.
   *
   * @param $class Class you want to link to
   * @param $tab an optional tab you want to link to
  */


  function get_url($tab = "")
  {
    $link = str_replace("index.php","",$_SERVER['SCRIPT_NAME'])."pentabarf";
    return $tab ? $link."/".$tab : $link;
  }

  function get_conference_url($class, $tab = "") {
    $link = str_replace("index.php","",$_SERVER['SCRIPT_NAME'])."pentabarf";
    $link .= "/conference/".(is_object($class) ? $class->get('conference_id') : $class);
    return $tab ? $link."#".$tab : $link;
  }

  function get_event_url($class, $tab = "") {
    $link = str_replace("index.php","",$_SERVER['SCRIPT_NAME'])."pentabarf";
    $link .= "/event/".(is_object($class) ? $class->get('event_id') : $class);
    return $tab ? $link."#".$tab : $link;
  }

  function get_person_url($class, $tab = "") {
    $link = str_replace("index.php","",$_SERVER['SCRIPT_NAME'])."pentabarf";
    $link .= "/person/".(is_object($class) ? $class->get('person_id') : $class);
    return $tab ? $link."#".$tab : $link;
  }

  function get_conference_image_url($class, $size = '32x32', $fixed = true) {
    global $preferences;
    $conference_id = is_object($class) ? $class->get('conference_id') : $class;
    $sizes = array('32x32', '16x16', '64x64', '128x128');
    if (!in_array($size, $sizes)) $size = $sizes[0];
    
    $link = str_replace("index.php","",$_SERVER['SCRIPT_NAME']);
    
    if ($conference_id == 0 || ($fixed == true && isset($preferences["images"]) && $preferences["images"]['conference'] == false)) {
      return $link."images/icon-conference-$size.png";
    } else {
      return $link."pentabarf/images/conference/".$conference_id."/$size";
    }
  }

  function get_event_image_url($class, $size = "32x32", $fixed = true) {
    global $preferences;
    $sizes = array('32x32', '16x16', '64x64', '128x128');
    if (!in_array($size, $sizes)) $size = $sizes[0];
    
    $link = str_replace("index.php","",$_SERVER['SCRIPT_NAME']);
    
    if ($fixed == true && isset($preferences["images"]) && $preferences["images"]['event'] == false) {
      return $link."images/icon-event-$size.png";
    } else {
      return $link."pentabarf/images/event/".(is_object($class) ? $class->get('event_id') : $class)."/$size";
    }
  }

  function get_person_image_url($class, $size = '32x32', $fixed = true) {
    global $preferences;
    $person_id = is_object($class) ? $class->get('person_id') : $class;
    $sizes = array('32x32', '16x16', '64x64', '128x128');
    if (!in_array($size, $sizes)) $size = $sizes[0];
    
    $link = str_replace('index.php','',$_SERVER['SCRIPT_NAME']);
    
    if ($person_id == 0 || ($fixed == true && isset($preferences['images']) && $preferences['images']['person'] == false)) {
      return $link."images/icon-person-$size.png";
    } else {
      return $link."pentabarf/images/person/".$person_id."/$size";
    }
  }


  /** Function for getting the URL to an attachment of an Object.
   *
   * @param $class Class you want to get the attachment link to.
  */


  function get_attachment_url($class)
  {
    $link = str_replace("index.php","",$_SERVER['SCRIPT_NAME'])."pentabarf/attachments/";

    if (is_object($class)) {
      $link .= "event/".$class->get('event_attachment_id').($class->get('filename') ? "/".$class->get('filename') : "");
    } else {
      throw new Exception("class not supported for get_attachment_url", 1);
    }
    return $link;
  }

?>
