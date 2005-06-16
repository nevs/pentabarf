<?php

  require_once('../db/conference.php');
  require_once('../db/event.php');
  require_once('../db/room.php');
  require_once('../db/event_person.php');
  require_once('../db/person.php');
  require_once('../db/language.php');
  require_once('../db/language_localized.php');
  require_once('../db/mime_type.php');
  require_once('../db/view_event_attachment.php');
  require_once('Date.php');

  $conference = new Conference;
  if ($conference->select(array('conference_id' => $RESOURCE)) == 0) {
    trigger_error('404 conference not found');
    require_once('../wwwroot/error.html');
    exit;
  }

  require_once('../patError/patErrorManager.php');
  require_once('../patTemplate/patTemplate.php');

  $lang = strstr($_SERVER['QUERY_STRING'], '.de.') ? 'de' : 'en';

  $sprache = new Language;
  $sprache->select(array('tag' => $lang));
  $sprache->set_language_id($sprache->get('language_id'));

  // initialize template engine
  $template = new patTemplate;
  $template->applyInputFilter('Translate');
  $template->setBasedir('../templates');
  $template->readTemplatesFromFile('html-main.tmpl');

  $LOCATION = $BASE_URL.'pentabarf/html2/conference/'.$conference->get('conference_id').'/';

  $css_prefix = ( isset($OPTIONS[0]) && ( $OPTIONS[0] == 'event' || $OPTIONS[0] == 'speaker' ) ) ? '../' : '';
  
  $template->addVar('main', 'CSS_FILE', $css_prefix.'fahrplan.css');
  $template->addGlobalVar('LANG', $lang);
  $template->addGlobalVar('ALT_LANG', $lang == 'de' ? 'en' : 'de');
  $template->addGlobalVar('RELEASE', $conference->get('release'));
  $template->addGlobalVar('CONFERENCE_TITLE', $conference->get('title'));
  $template->addGlobalVar('CONFERENCE_ACRONYM', $conference->get('acronym'));


  $days = array();
  for ($i = 1; $i <= $conference->get('days'); $i++) {
    array_push($days, array('DAY' => $i));
  }
  $template->addRows('days', $days);
  // we dont want to see days for schedule here
  $template->setAttribute("days", "visibility", "hidden");
  

  if (!isset($OPTIONS[0])) {
    header("Location: $LOCATION");
    exit;
  } else if ($OPTIONS[0] == "fahrplan.css") {
    // output css 
    header('Content-type: text/css');
    echo $conference->get('css');
    exit;
  } else if ($OPTIONS[0] == "event") {
    if (isset($OPTIONS[1]) && $OPTIONS[1] == "images" && isset($OPTIONS[2])) {
      require_once("../db/event_image.php");
      $class = new Event_Image;
      $ID = strtok($OPTIONS[2],".");
      if ($class->select(array("event_id" => $ID))) {
        $type = new Mime_Type;
        $type->select(array("mime_type_id" => $class->get("mime_type_id")));
        header("Content-type: ".$type->get("mime_type")); 
        echo $class->get("image");
        exit;
      } else{
        require_once("images/icon-event-128x128.png");
        exit;
      }
    } else {
      require_once("html2-conference-event.php");
    }
  } else if (substr($OPTIONS[0],0,6) == "events") {
      // event index
      require_once("html2-conference-event-index.php");
      exit;
  } else if ($OPTIONS[0] == "speaker") {
    if (isset($OPTIONS[1]) && $OPTIONS[1] == "images" && isset($OPTIONS[2])) {
      require_once("../db/person_image.php");
      $class = new Person_Image;
      $ID = strtok($OPTIONS[2],".");
      if ($class->select(array("person_id" => $ID)) && $class->get("f_public") == 't') {
        $type = new Mime_Type;
        $type->select(array("mime_type_id" => $class->get("mime_type_id")));
        header("Content-type: ".$type->get("mime_type")); 
        echo $class->get("image");
        exit;
      } else {
        require_once("images/icon-person-128x128.png");
        exit;
      }
    } else {
      require_once("html-conference-speaker.php");
    }
  } else if (substr($OPTIONS[0],0,8) == "speakers") {
    // speaker index
    require_once("html-conference-speaker-index.php");
    exit;
  } else if ($OPTIONS[0] == "files") {
    // attachment stuff
    require_once('../db/event_attachment.php');
    $attachment = new View_Event_Attachment;
    if ($attachment->select(array('event_attachment_id' => strtok($OPTIONS[1], '-')))) {
      $type = new Mime_Type;
      $type->select(array("mime_type_id" => $attachment->get("mime_type_id")));
      header("Content-type: ".$type->get("mime_type")); 
      header("Content-Length: ".$attachment->get('filesize')); 
      echo $attachment->get('data');
    }
    exit;
    
  } else if ($OPTIONS[0] == "fahrplan.css") {
    // css file
    header("Content-type: text/css");
    require_once("css/fahrplan.css");
    exit;
  } else if (isset($OPTIONS[1])) {
    // redirect for sanity
    header("Location: $LOCATION");
    exit;
  } else {
    $template->addVar('main', 'DOC_NAME', 'index');
    $template->readTemplatesFromFile('html-base.tmpl');
    $template->setAttribute("ics_file", "visibility", "hidden");
    $template->displayParsedTemplate('main');
  }

?>
