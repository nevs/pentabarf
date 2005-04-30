<?php
  
  require_once('../db/view_event_person_person_with_role_state.php');
  require_once('../db/view_fahrplan_event.php');
  require_once('../db/event_type_localized.php');
  require_once('../db/conference_track.php');
  require_once('../db/view_event_link.php');
  require_once('../db/event_image.php');
  require_once('../db/mime_type.php');
  require_once('../db/view_language.php');
  require_once('../db/view_ui_message.php');
  require_once('Date.php');

  $template->readTemplatesFromFile('html-event-index.tmpl');

  $messages = new View_UI_Message;
  $messages->select(array('tag' => "lectures-and-workshops", 'language_id' => $messages->get_language_id()));
  $lectures_and_workshops = $messages->get('name');

  $template->addVar('main', 'TITLE', "{$conference->get("acronym")}: {$lectures_and_workshops}");

  $template->addVar('main', 'DOC_NAME', 'events');
  
  $event = new View_Fahrplan_Event;
  $event->select(array('conference_id' => $conference->get("conference_id"), 'f_public' => 't'));
  $event_speaker = new View_Event_Person_Person_with_Role_State;
  $image = new Event_Image;

  $events = array();
  foreach($event as $value) {

    if ($image->select( array("event_id" => $event->get("event_id") ) ) ) {
      $mime_type = new Mime_Type;
      $mime_type->select( array("mime_type_id" => $image->get("mime_type_id")) );
      $extension = $mime_type->get("file_extension");
    } else {
      $extension = "png";
    }
    
    $event_speaker->select(array('event_id' => $event->get('event_id'), 'event_role_state_tag' => 'confirmed', 'event_role_tag' => array('moderator', 'speaker')));
    $speaker_urls = array();
    $speaker_names = array();
    foreach($event_speaker as $value) {
      array_push($speaker_urls, "speaker/{$event_speaker->get('person_id')}.$lang.html");
      array_push($speaker_names, $event_speaker->get('name'));
    }


    $track = new Conference_Track;
    $track->select( array ('conference_track_id' => $event->get('conference_track_id')));
  
    $event_type = new Event_Type_Localized;
    $event_type->select(array('event_type_id' => $event->get('event_type_id'), 'language_id' => $sprache->get('language_id')));
  
    $room = new Room;
    $room->select( array("room_id" => $event->get("room_id")));

    $language = new View_Language;
    if ($event->get('language_id')) {
      $language->select(array('translated_id' => $event->get('language_id'), 'language_id' => $sprache->get('language_id')));
    } else {
      $language->clear();
    }

    array_push($events, array(
      'EVENT_ID'          => $event->get('event_id'),
      'EVENT_URL'         => "event/{$event->get('event_id')}.{$lang}.html",
      'EVENT_TITLE'       => $event->get('title'),
      'EVENT_SUBTITLE'    => $event->get('subtitle'),
      'EVENT_LANGUAGE'    => $language->get_count() ? $language->get('name') : '',
      'EVENT_TRACK'       => $track->get('tag'),
      'EVENT_TYPE'        => $event_type->get('name'),
      'EVENT_ROOM'        => $room->get('short_name'),
      'EVENT_IMAGE_URL'   => "event/images/{$event->get('event_id')}.{$extension}" ,
      'FEEDBACK_LINK'     => "{$conference->get('feedback_base_url')}event/{$event->get('event_id')}.html",
      'SPEAKER_URL'       => $speaker_urls,
      'SPEAKER_NAME'      => $speaker_names,
      ));

  }

  $template->addRows('event', $events);
  $template->displayParsedTemplate('main');

?>
