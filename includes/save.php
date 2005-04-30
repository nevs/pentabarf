<?php

  /* 
   * This is the switch for all save actions
  */
/*
  try
  {
*/
    if (isset($_POST['change_conference'])) {
      
      // save user conference
      $preferences = $auth_person->get('preferences');
      $preferences['conference'] = $_POST['change_conference'];
      $auth_person->set('preferences', $preferences);
      $auth_person->write();
      header("Location: {$_SERVER['HTTP_REFERER']}");
      exit;
  
    } else {
      
      $new_dataset = false;
  
      switch($VIEW){
        case "new_conference":
        case "new_event":
        case "new_person":
          $VIEW = str_replace("new_","",$VIEW);
          $new_dataset = true;
        case "conference":
        case "event":
        case "person":
          require_once("save_".$VIEW.".php");
          break;
          
      }
  
    }
/*  } catch(Exception $e) {
    trigger_error("Error while Saving: ".$e->getMessage()."\nFile: ".$e->getFile()." Line: ".$e->getLine()."\nTrace:\n".$e->getTraceAsString());
  }*/

  header("Location: ".get_url(0,"$VIEW/$RESOURCE"));
  exit;
    

?>
