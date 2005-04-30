<?php
  
  require_once('../db/view_event_person_person_with_role_state.php');
  require_once('../db/view_fahrplan_event.php');
  require_once('../db/view_event.php');
  require_once('../db/event_type_localized.php');
  require_once('../db/conference_track.php');
  require_once('../db/view_event_link.php');
  require_once('../db/event_image.php');
  require_once('../db/person_image.php');
  require_once('../db/mime_type.php');
  require_once('../db/view_event_attachment.php');
  require_once('../db/view_ui_message.php');
  require_once('Date.php');

  $template->readTemplatesFromFile('html-event.tmpl');

  $messages = new View_UI_Message;
  $messages->select(array('tag' => "lectures-and-workshops", 'language_id' => $messages->get_language_id()));
  $lectures_and_workshops = $messages->get('name');

  $event = new View_Event;

  $event_id = isset($OPTIONS[0]) ? intval(preg_replace('/([0-9]+)\..*/', '\1', $OPTIONS[1])) : 0;

  if (!$event_id || !$event->select( array('event_id' => $event_id)) ) {
    header ("Location: $LOCATION");
    exit;
  }

  $template->addGlobalVar('EXPORT_BASE_URL', '../');
  $template->addVar('main', 'TITLE', "{$conference->get("acronym")}: {$lectures_and_workshops}: {$event->get('title')}");
  $template->addVar('main', 'DOC_NAME', $event->get('event_id'));
  
  $template->addVar('content', 'EVENT_TITLE', $event->get('title'));
  $template->addVar('content', 'EVENT_SUBTITLE', $event->get('subtitle'));
  $template->addVar('content', 'EVENT_ID', $event_id);
  $template->addVar('content', 'EVENT_DAY', $event->get('day'));
  $template->addVar('content', 'EVENT_TIME', $event->get('real_start_time')->format('%H:%M'));
  $template->addVar('content', 'EVENT_DURATION', $event->get('duration')->format('%H:%M'));
  $template->addVar('content', 'ABSTRACT', $event->get('abstract'));
  $template->addVar('content', 'DESCRIPTION', $event->get('description'));

  $track = new Conference_Track;
  if ($track->select( array ('conference_track_id' => $event->get('conference_track_id'))) == 1) {
    $template->addVar('content', 'EVENT_TRACK', $track->get('tag'));
  }
  $event_type = new Event_Type_Localized;
  if ($event_type->select(array('event_type_id' => $event->get('event_type_id'), 'language_id' => $sprache->get('language_id'))) == 1) {
    $template->addVar('content', 'EVENT_TYPE', $event_type->get('name'));
  }
  $room = new Room;
  if ($room->select( array('room_id' => $event->get('room_id'))) == 1) {
    $template->addVar('content', 'EVENT_ROOM', $room->get('short_name'));
  }

  // Hack for Event Navigation
  
  $event_nav = new View_Fahrplan_Event;
  $event_nav->select(array('conference_id' => $conference->get('conference_id'), 'f_public' => 't'));

  // search current event
  foreach($event_nav as $key) {
    if ($event_nav->get('event_id') == $event->get('event_id')) break;
  }
  
  if($event_nav->get_prev('event_id')) {
    $template->addVar('content', 'NAV_PREV_URL', $event_nav->get_prev('event_id').'.'.$lang.'.html');
    $template->addVar('content', 'NAV_PREV_TITLE', $event_nav->get_prev('title'));
  }

  $template->addVar('content', 'NAV_CURRENT_NUMBER', $event_nav->current() + 1);
  $template->addVar('content', 'NAV_TOTAL_NUMBER', $event_nav->get_count());

  if($event_nav->get_next('event_id')) {
    $template->addVar('content', 'NAV_NEXT_URL', $event_nav->get_next('event_id').'.'.$lang.'.html');
    $template->addVar('content', 'NAV_NEXT_TITLE', $event_nav->get_next('title'));
  }

  $image = new Event_Image;
  if ($image->select( array('event_id' => $event->get('event_id') ) ) ) {
    $mime_type = new Mime_Type;
    $mime_type->select( array('mime_type_id' => $image->get('mime_type_id')) );
    $extension = $mime_type->get('file_extension');
  } else {
    $extension = 'png';
  }
  $template->addVar('content', 'IMAGE_URL', "../event/images/{$event->get('event_id')}.{$extension}");


  // Generate list of speakers

  $event_speaker = new View_Event_Person_Person_with_Role_State;
  $event_speaker->select(array('event_id' => $event->get('event_id'), 'event_role_tag' => 'speaker', 'event_role_state_tag' => 'confirmed' ));

  $speakers = array();
  foreach($event_speaker as $value){

    $image = new Person_Image;
    if ($image->select( array("person_id" => $event_speaker->get("person_id"))) && $image->get("f_public") == 't') {
      $mime_type = new Mime_Type;
      $mime_type->select( array("mime_type_id" => $image->get("mime_type_id")));
      $extension = $mime_type->get("file_extension");
    } else {
      $extension = "png";
    }

    array_push($speakers, array(
      'SPEAKER_URL'        => "../speaker/{$event_speaker->get('person_id')}.$lang.html",
      'SPEAKER_IMAGE_URL'  => "../speaker/images/{$event_speaker->get('person_id')}.{$extension}",
      'SPEAKER_NAME'       => $event_speaker->get('name'))
    );
  }
  $template->addRows('speaker-list', $speakers);



  // Generate list of moderators

  $event_moderator = new View_Event_Person_Person_with_Role_State;
  $event_moderator->select(array('event_id' => $event->get('event_id'), 'event_role_tag' => 'moderator', 'event_role_state_tag' => 'confirmed' ));

  $moderators = array();
  foreach($event_moderator as $value){

    $image = new Person_Image;
    if ($image->select( array("person_id" => $event_moderator->get("person_id"))) && $image->get("f_public") == 't') {
      $mime_type = new Mime_Type;
      $mime_type->select( array("mime_type_id" => $image->get("mime_type_id")));
      $extension = $mime_type->get("file_extension");
    } else {
      $extension = "png";
    }

    array_push($moderators, array(
      'MODERATOR_URL'        => "../speaker/{$event_moderator->get('person_id')}.$lang.html",
      'MODERATOR_IMAGE_URL'  => "../speaker/images/{$event_moderator->get('person_id')}.{$extension}",
      'MODERATOR_NAME'       => $event_moderator->get('name'))
    );
  }
  $template->addRows('moderator-list', $moderators);




  $template->addVar('content', 'FEEDBACK_LINK', "{$conference->get('feedback_base_url')}event/{$event->get('event_id')}.html");

  $language = new Language_Localized;
  if ($event->get('language_id') && $language->select( array('translated_id' => $event->get('language_id'), 'language_id' => $sprache->get('language_id')))) {
    $template->addVar('content', 'EVENT_LANGUAGE', $language->get('name'));
  }


  // display links

  $link = new View_Event_Link;
  $link->select(array('event_id' => $event->get('event_id'), 'f_public' => 't' ));

  $links = array();
  foreach ($link as $value) {
    $link_url = $link->get('url');
    $link_title = $link->get('title');
    if ($link_title == '') {
        $link_title = $link_url;
    }
    array_push($links, array('LINK_URL' => $link_url, 'LINK_TITLE' => $link_title));
  }

  $template->addRows('link-list', $links);



  // display files

  $files = array();
  $attachment = new View_Event_Attachment;
  $attachment->select(array('event_id' => $event->get('event_id'), 'f_public' => 't'));
  foreach ($attachment as $value) {
    $mime_type = new MIME_Type;
    $mime_type->select(array('mime_type_id' => $attachment->get('mime_type_id')));

    $name = "{$attachment->get('event_attachment_id')}-{$attachment->get('filename')}";
    $title = $attachment->get('title');
    if ($title == '') {
        $title = $name;
    }

    $filesize = $attachment->get('filesize');
    if ($filesize < 900) {
        $filesize .= ' Byte';
    } else if ($filesize < 900000) {
        $filesize /= 1024;
        $filesize = sprintf('%.1f', $filesize);
        $filesize .= ' KByte';
    } else {
        $filesize /= 1048576;
        $filesize = sprintf('%.1f', $filesize);
        $filesize .= ' MByte';
    }

    array_push($files, array(
      'FILE_URL' => "../files/{$name}",
      'FILE_TYPE' => strtoupper($mime_type->get('file_extension')),
      'FILE_SIZE' => $filesize,
      'FILE_TITLE' => $title));
  }
  $template->addRows('file-list', $files);

  $template->displayParsedTemplate('main');

?>
