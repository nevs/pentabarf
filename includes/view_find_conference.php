<?php

  require_once("../db/person.php");
  require_once("../db/find_conference.php");
  require_once("../db/person_watchlist_conference.php");
  require_once("../functions/tabs.php");

  $template->readTemplatesFromFile("view_find_conference.tmpl");

  $template->addVar("main","CONTENT_TITLE", "Find Conference");
  $template->addVar("main","VIEW_TITLE", "Find Conference");
  
  
  // array with the names of the js-switched tabs
  $tabnames = array("simple", "advanced");
 
  content_tabs($tabnames, $template);
  
  $person = new Person;
  $conference = new Find_Conference;

  if (isset($_POST['find_conferences'])) {
    $preferences['find_conferences'] = $_POST['find_conferences'];
    $auth_person->set('preferences', $preferences);
    if ($auth_person->check_authorisation("modify_own_person")) {
      $auth_person->write();
    }
    header("Location: {$BASE_URL}pentabarf/find_conference");
    exit;
  }

  if (!isset( $preferences['find_conferences'] ) ) {
    $preferences['find_conferences'] = "";
    $auth_person->set('preferences', $preferences);
    if ($auth_person->check_authorisation("modify_own_person")) {
      $auth_person->write();
    }
  }

  if (preg_match('/^[0-9 ]+$/', $preferences['find_conferences'])) {
    // searching for multiple ids
    $find = explode(' ', $preferences['find_conferences']);
    $search_set = array();
    foreach ($find as $value) {
      array_push($search_set, array('type' => 'conference_id', 'logic' => 'is', 'value' => $value));
    }
  } else {
    $find = explode(' ', $preferences['find_conferences']);
    $search_set = array();
    foreach ($find as $value) {
      array_push($search_set, array('type' => 'title', 'logic' => 'contains', 'value' => $value)); 
    }
  }

  $count = $conference->select($search_set); 

  if ($count) {
    $result = array();
    $watchlist = new Person_Watchlist_Conference;
    foreach($conference as $key) {
        array_push($result,array(
          'URL'            => get_conference_url($conference),
          'IMAGE_URL'      => get_conference_image_url($conference, "32x32"),
          'CONFERENCE_ID'  => $conference->get('conference_id'),
          'TITLE'          => $conference->get('title'),
          'SUBTITLE'       => $conference->get('subtitle'),
          'ACRONYM'        => $conference->get('acronym'),
          'WATCH_BUTTON'   => $watchlist->select(array('person_id' => $watchlist->get_auth_person_id(), 'conference_id' => $conference->get('conference_id'))) ? $GLOBAL_TEXT_WATCHED : $GLOBAL_TEXT_UNWATCHED
          ));
    }
    $template->addVar("result","RESULT",$count." Hit".($count == 1 ? "" : "s"));
    $template->addRows("result_element",$result);
  } else {
    $template->addVar("result","RESULT","Nothing found");
  }

  $template->addVar("content","FIND", $preferences['find_conferences']);

?>
