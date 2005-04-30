<?php
  
  require_once("../db/find_person.php");
  require_once("../db/person_watchlist_person.php");
  require_once("../db/keyword_localized.php");
  require_once("../functions/tabs.php");
  require_once("../functions/search.php");

  $template->readTemplatesFromFile("view_find_person.tmpl");

  // array with the names of the tabs
  $tabnames = array("simple","advanced");
 
  content_tabs($tabnames, $template, $preferences['find_persons_type']);
  
  $template->addVar("main","CONTENT_TITLE", "Find Person");
  $template->addVar("main","VIEW_TITLE", "Find Person");
  
  $person = new Find_Person();

  $keyword = new Keyword_Localized;
  $keyword->select(array('language_id' => $preferences['language']));
  add_js_vars("valuelists[2]", $keyword, 'keyword_id', 'name', $is_array = true);
  
  if (isset($_POST['search']) || isset($_POST['find_persons'])) {
    if (isset($_POST['search']) && is_array($_POST['search'])) {
      usort($_POST['search'], "compare_search");
      $preferences['find_persons_advanced'] = $_POST['search'];
      $preferences['find_persons_type'] = 'advanced';
    } else if (isset($_POST['find_persons'])) {
      $preferences['find_persons'] = $_POST['find_persons'];
      $preferences['find_persons_type'] = 'simple';
    } 
    $auth_person->set('preferences', $preferences);
    if ($auth_person->check_authorisation("modify_own_person")) {
      $auth_person->write();
    }
    header("Location: {$BASE_URL}pentabarf/find_person");
    exit;
  }


  // restore search set
  if (is_array($preferences['find_persons_advanced']) && count($preferences['find_persons_advanced'])) {
    foreach($preferences['find_persons_advanced'] as $value){
      array_push($init, array('FUNCTION' => "search_criteria_add('search_elements', 0, '".addslashes($value['type'])."', '".addslashes($value['logic'])."', '".addslashes($value['value'])."');"));
    }
  } else {
    array_push($init, array('FUNCTION' => "search_criteria_add('search_elements', 0);"));
  }
  $template->addVar("content","FIND", $preferences['find_persons']);


  if ($preferences['find_persons_type'] == 'advanced') {
    $search_set = $preferences['find_persons_advanced'];
  } else {
    if (preg_match('/^[0-9 ]+$/', $preferences['find_persons'])) {
      // searching for multiple ids
      $find = explode(' ', $preferences['find_persons']);
      $search_set = array();
      foreach ($find as $value) {
        array_push($search_set, array('type' => 'person_id', 'logic' => 'is', 'value' => $value));
      }
    } else {
      $find = explode(' ', $preferences['find_persons']);
      $search_set = array();
      foreach ($find as $value) {
        array_push($search_set, array('type' => 'name', 'logic' => 'contains', 'value' => $value));
      }
    }
  }


  $count = $person->select($search_set);


  if ($count) {
    $watchlist = new Person_Watchlist_Person;
    $result = array();
    foreach($person as $key){
      array_push($result, array(
          'URL'           => get_person_url($person),
          'IMAGE_URL'     => get_person_image_url($person),
          'NAME'          => $person->get('name'),
          'PERSON_ID'     => $person->get('person_id'),
          'BUTTON_WATCH'  => $watchlist->select(array('person_id' => $watchlist->get_auth_person_id(), 'watched_person_id' => $person->get('person_id'))) ? $GLOBAL_TEXT_WATCHED : $GLOBAL_TEXT_UNWATCHED
        ));
    }
    $template->addVar("result","RESULT",$count." Hit".($count == 1 ? "" : "s"));
    $template->addRows("result_element",$result);
  } else {
    $template->addVar("result","RESULT","Nothing found");
  }
  
?>
