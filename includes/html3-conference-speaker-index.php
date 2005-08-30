<?php

  require_once('../db/view_person_link.php');
  require_once('../db/view_event.php');
  require_once('../db/view_fahrplan_person_preview.php');
  require_once('../db/view_fahrplan_person_event.php');
  require_once('../db/view_event_person_event.php');
  require_once('../db/person_image.php');
  require_once('../db/mime_type.php');
  require_once('../functions/markdown.php');
  require_once('../db/view_ui_message.php');

  $template->readTemplatesFromFile("html-speaker-index.tmpl");

  $messages = new View_UI_Message;
  $messages->select(array('tag' => "speakers-and-moderators", 'language_id' => $messages->get_language_id()));
  $speakers_and_moderators = $messages->get('name');

  $template->addVar('main', 'TITLE', "{$conference->get("acronym")}: {$speakers_and_moderators}");
  $template->addVar('main', 'DOC_NAME', 'speakers');

  $person = new View_Fahrplan_Person_Preview;
  $person->select(array('conference_id' => $conference->get("conference_id")));

  $event = new Event;
  $image = new Person_Image;
  $mime_type = new Mime_Type;
  $speaker = array();
  foreach($person as $value) {
  
    $image->select( array("person_id" => $person->get("person_id")));
    if ($image->get_count() && $image->get("f_public") == 't') {
      $mime_type->select( array("mime_type_id" => $image->get("mime_type_id")));
      $extension = $mime_type->get("file_extension");
    } else {
      $extension = "png";
    }
    
    $event= new View_Fahrplan_Person_Event;
    $event->select(array('person_id' => $person->get("person_id"), 'conference_id' => $conference->get("conference_id"), 'event_role_tag' => array('speaker', 'moderator')));
    $event_urls = array();
    $event_title = array();
    foreach($event as $value) {
      array_push($event_title, $event->get('title'));
      array_push($event_urls, "event/{$event->get('event_id')}.html.{$lang}");
    }

    array_push($speaker, array(
      'SPEAKER_IMAGE_URL' => "speaker/images/{$person->get('person_id')}.{$extension}", 
      'SPEAKER_URL'       => "speaker/{$person->get('person_id')}.html.{$lang}",
      'SPEAKER_NAME'      => $person->get('name'),
      'EVENT_URL'         => $event_urls,
      'EVENT_TITLE'       => $event_title
      ));

  }
  $template->addRows('speaker', $speaker);

  $template->displayParsedTemplate('main');
  
?>
