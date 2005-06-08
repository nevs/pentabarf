<?php

  require_once('../db/view_person_link.php');
  require_once('../db/view_person.php');
  require_once('../db/view_event.php');
  require_once('../db/view_event_person_with_role_state.php');
  require_once('../db/view_fahrplan_person_event.php');
  require_once('../db/view_fahrplan_person.php');
  require_once('../db/person_image.php');
  require_once('../db/event_image.php');
  require_once('../db/mime_type.php');
  require_once('../functions/markdown.php');
  require_once('../db/view_ui_message.php');

  $template->readTemplatesFromFile("html-speaker.tmpl");


  $messages = new View_UI_Message;
  $messages->select(array('tag' => "speakers-and-moderators", 'language_id' => $messages->get_language_id()));
  $speakers_and_moderators = $messages->get('name');


  $person = new View_Person;
  $person_id = isset($OPTIONS[1]) ? intval(preg_replace('/([0-9]+)\..*/', '\1', $OPTIONS[1])) : 0;

  if (!$person_id || !$person->select( array("person_id" => $person_id))) {
    header("Location: $LOCATION");
    exit;
  }

  $template->addGlobalVar('EXPORT_BASE_URL', '../');
  $template->addVar('main', 'TITLE', "{$conference->get("acronym")}: {$speakers_and_moderators}: {$person->get("name")}");
  $template->addVar('main', 'DOC_NAME', $person->get('person_id'));

  $template->addVar('content', 'SPEAKER_NAME', $person->get('name'));

  $template->addVar('content', 'ABSTRACT', $person->get('abstract'));
  $template->addVar('content', 'DESCRIPTION', $person->get('description'));

  if ($person->get("email_public")) {
    $email = str_replace(array("@", "."), array(" at ", " dot "),$person->get("email_public"));
    $template->addVar('content', 'SPEAKER_EMAIL', $email);
  }

  // Hack for Person Navigation

  $person_nav = new View_Fahrplan_Person;
  $person_nav->select(array('conference_id' => $conference->get("conference_id")));

  // search current person
  foreach($person_nav as $key) {
    if ($person_nav->get('person_id') == $person->get('person_id')) break;
  }
  
  if($person_nav->get_prev('person_id')) {
    $template->addVar('content', 'NAV_PREV_URL', $person_nav->get_prev('person_id').'.'.$lang.'.html');
    $template->addVar('content', 'NAV_PREV_TITLE', $person_nav->get_prev('name'));
  }

  $template->addVar('content', 'NAV_CURRENT_NUMBER', $person_nav->current() + 1);
  $template->addVar('content', 'NAV_TOTAL_NUMBER', $person_nav->get_count());

  if($person_nav->get_next('person_id')) {
    $template->addVar('content', 'NAV_NEXT_URL', $person_nav->get_next('person_id').'.'.$lang.'.html');
    $template->addVar('content', 'NAV_NEXT_TITLE', $person_nav->get_next('name'));
  }


  $image = new Person_Image;
  if ($image->select( array("person_id" => $person->get("person_id"))) && $image->get("f_public") == 't') {
    $mime_type = new Mime_Type;
    $mime_type->select( array("mime_type_id" => $image->get("mime_type_id")));
    $extension = $mime_type->get("file_extension");
  } else {
    $extension = "png";
  }
  $template->addVar('content', 'SPEAKER_IMAGE_URL', "../speaker/images/{$person->get("person_id")}.{$extension}");


  // display related events
  
  $event_person = new View_Fahrplan_Person_Event;
  $event_person->select(array('person_id' => $person->get("person_id"), 'conference_id' => $conference->get("conference_id")));
  $events = array();
  foreach ($event_person as $value) {

    $image = new Event_Image;
    if ($image->select( array('event_id' => $event_person->get('event_id') ) ) ) {
      $mime_type = new Mime_Type;
      $mime_type->select( array('mime_type_id' => $image->get('mime_type_id')) );
      $extension = $mime_type->get('file_extension');
    } else {
      $extension = 'png';
    }

    array_push($events, array(
      'EVENT_ID'          => $event_person->get('event_id'),
      'EVENT_URL'         => "../event/{$event_person->get('event_id')}.$lang.html",
      'EVENT_IMAGE_URL'   => "../event/images/{$event_person->get('event_id')}.$extension",
      'EVENT_TITLE'       => $event_person->get('title'),
      'EVENT_SUBTITLE'       => $event_person->get('subtitle')
      ));
  }
  $template->addRows('event-list', $events);

  
  // display links
  $person_link = new View_Person_Link;
  $person_link->select(array('person_id' => $person->get("person_id"), 'f_public' => 't' ));
  
  $links = array();
  foreach($person_link as $v) {
    array_push($links, array(
      'LINK_URL' => $person_link->get('url'),
      'LINK_TITLE' => $person_link->get('title') == "" ? $person_link->get('url') : $person_link->get('title')
      ));
  }
  $template->addRows('links', $links);


  $template->displayParsedTemplate('main');

?>
