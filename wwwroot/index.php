<?php

  require_once('../includes/globals.php');
  require_once('../functions/error_handler.php');
  require_once('../functions/exception_handler.php');
  require_once('../patError/patErrorManager.php');
  require_once('../patTemplate/patTemplate.php');
  require_once('../db/auth_person.php');
  require_once('../db/conference.php');
  require_once('../db/view_last_active.php');
  require_once('../functions/js_functions.php');
  require_once('../functions/fill_select.php');
  require_once('../functions/get_url.php');
  require_once('../functions/tabs.php');


  // authenticate Person
  $auth_person = new Auth_Person;
  $preferences = $auth_person->get('preferences');
  
  // initialize template engine
  $template = new patTemplate;
  $template->applyInputFilter('Translate');
  $template->setBasedir('../templates');
  $template->readTemplatesFromFile('main.tmpl');

  // get the current revision
  $revision_file = '../revision.txt';
  if (is_readable($revision_file) && $file = fopen($revision_file,'r')) {
    $rev_number = fgets($file);
    $REVISION = (integer) $rev_number;
    $template->addGlobalVar('REVISION', $REVISION);
    fclose($file);
  }

  $BASE_URL = str_replace('index.php','',$_SERVER['SCRIPT_NAME']);
  $template->addGlobalVar('AUTH_PERSON_ID', $auth_person->get_auth_person_id());
  $template->addGlobalVar('AUTH_PERSON_SALUTATION', $auth_person->get('name'));
  $template->addGlobalVar('BASE_URL', $BASE_URL);
  $template->addGlobalVar('AUTH_LOGIN_NAME', $auth_person->get_auth_login_name());

  // put URL parts in $VIEW, $RESOURCE and $OPTIONS
  $OPTIONS = explode('/',$_SERVER['QUERY_STRING']);
  $VIEW = strtolower(array_shift($OPTIONS));
  $RESOURCE = array_shift($OPTIONS);

  // get conference if user has no conference and check for valid conference_id 
  $conference = new Conference;
  if ( !$preferences['conference'] && $conference->select( array( 'conference_id' => $preferences['conference'] ) ) != 1 )
  {
    $conference->set_limit(1);
    if ( $conference->select() == 1 )
    {
      $preferences['conference'] = $conference->get('conference_id');
    } else {
      // there is no conference yet
      $preferences['conference'] = 0;
    }
    $auth_person->set('preferences', $preferences);
    if ($auth_person->check_authorisation('modify_own_person')) {
      $auth_person->write();
    }
  }
  $template->addGlobalVar('CURRENT_CONFERENCE_ID', $preferences['conference']);


  // do we have to save data
  if (isset($_POST["save"]))
  {
    require_once("../includes/save.php");
    exit;
  }
  
  $content_views = array("home", "watchlist", "person", "find_person", "new_person", "event", "find_event", "new_event", "conference", "find_conference", "new_conference", "setup", "preferences", "recent_changes", "reports", "conflicts");

  if ($VIEW && !in_array($VIEW, $content_views)) {
    require_once("error.html");
    trigger_error("404 Page not found.");
    exit;
  }
  
  $VIEW = $content_views[array_search($VIEW, $content_views)];
  foreach($content_views as $value)
  {
    $template->addVar("sidebar","ITEM_STATE_".strtoupper($value), $value == $VIEW ? "selected" : "off");
  }
  require_once("../includes/view_$VIEW.php");

  
  // get data for conference selection in the sidebar
  $conference = new Conference;
  if ($conference->select()) {
    fill_select("conference_list", $conference, "conference_id", "acronym", $preferences['conference'] , FALSE);
  }

  $person = new View_Last_Active;
  // get the last logged in users
  $last_user = array();
  if ($person->select()) {
    foreach($person as $key) {
      array_push($last_user,array(
        'LOGIN_NAME'  => $person->get('login_name'),
        'URL'         => get_person_url($person),
        'NAME'        => $person->get('name'),
        'TIME'        => $person->get('login_diff')->format('%M:%S')
       ));
    }
  } else { 
    $last_user[0]['LOGIN_NAME'] = "you are alone";
  }
  $template->addRows("last_user",$last_user);

  add_js_to_template($template);
  $template->addGlobalVar("VIEW_URL", $BASE_URL."pentabarf/$VIEW/$RESOURCE"); 
  $template->displayParsedTemplate("main");

?>
