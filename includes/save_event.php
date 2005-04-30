<?php

  require_once('../db/event.php');
  require_once('../db/event_rating.php');
  require_once('../db/event_related.php');
  require_once('../db/event_person.php');
  require_once('../db/conference_track.php');
  require_once('../db/event_link.php');
  require_once('../db/person_watchlist_event.php');
  require_once('../db/event_transaction.php');
  require_once('../db/event_image.php');
  require_once('../db/event_attachment.php');
  require_once('../db/event_keyword.php');
  require_once('../functions/save-common.php');

  if (!$new_dataset){
    $transaction = new Event_Transaction;
    if ( $transaction->select(array('event_id' => $_POST['event_id'])) && 
         $transaction->get('changed_when') != $_POST['timestamp']) {
      trigger_error('Outdated data');
      die('Outdated data');
    }
  } 

  $event = new Event;
  $event->begin();
  if ($event->select(array('event_id' => $_POST['event_id'])) != 1) {
    $event->create();
  }

  foreach($event->get_field_names() as $value) {
    if ($value == 'event_id' || $value == 'f_public') continue;
    if (isset($_POST[$value])) {
      $event->set($value, $_POST[$value]);
    }
  }
  $event->set('f_public', isset($_POST['f_public']) ? 't' : 'f');
  $event->set('f_paper', isset($_POST['f_paper']) ? 't' : 'f');
  $event->set('f_slides', isset($_POST['f_slides']) ? 't' : 'f');
  
  // check whether the conference track really belongs to the current conference
  if ($event->get('conference_track_id')) {
    $event_section = new Conference_Track;
    $event_section->select(array('conference_track_id' => $event->get('conference_track_id')));
    if ($event_section->get('conference_id') != $event->get('conference_id')) {
      $event->set('conference_track_id', 0);
    }
  }
  $event->write(TRANSACTION);
  
  $rating = new Event_Rating;
  if (($rating->select(array('person_id' => $event->get_auth_person_id(),'event_id' => $event->get('event_id')))) == 1 ) {
    if ($event->get('event_id') != $rating->get('event_id')) {
      // new record
      $rating->create();
      $rating->set('event_id', $event->get('event_id'));
      $rating->set('person_id', $event->get_auth_person_id());
    }
    foreach($rating->get_field_names() as $value) {
      if ($value == 'event_id' || $value == 'person_id' || $value == 'remark') continue;
      if (isset($_POST[$value])) {
        $rating->set($value, $_POST[$value]);
      }
    }
    $rating->set('remark', $_POST['rating_remark']);
    $rating->write(TRANSACTION);
  }

  $event_person = new Event_Person;
  if (isset($_POST['event_person']) && is_array($_POST['event_person'])) {
    $created = array();
    foreach($_POST['event_person'] as $key => $value) {
      $event_person->clear();
      if (in_array($value['person_id'].':'.$value['event_role_id'], $created)) continue;
      if ($event_person->select(array('event_person_id' => $value['event_person_id'])) != 1) {
        $event_person->create();
      }
      if (isset($value['delete'])) {
        if ($event_person->get('event_person_id')) $event_person->delete(TRANSACTION);
        continue;
      }
      $event_person->set('event_id', $event->get('event_id'));
      $event_person->set('person_id', $value['person_id']);
      $event_person->set('event_role_id', $value['event_role_id']);
      $event_person->set('event_role_state_id', isset($value['event_role_state_id']) ? $value['event_role_state_id'] : 0);
      $event_person->set('remark', $value['remark']);
      $event_person->write(TRANSACTION);
      array_push($created, $value['person_id'].':'.$value['event_role_id']);
    }
  }

  $event_link = new Event_Link;
  save_link($event_link, 'event', $event->get('event_id'));

  $image = new Event_Image;
  $mime_type = new MIME_Type;
  if (isset($_FILES['image']) && $_FILES['image']['size'] != 0)
  {
    if ($mime_type->select(array('mime_type' => $_FILES['image']['type'], 'f_image' => 't')) != 1) {
      throw new Exception("Unsupported MIME_Type: {$_FILES['image']['type']}");
    } else {
      if ($image->select(array('event_id' => $event->get('event_id'))) == 1) {
        $image->delete(TRANSACTION);
      }
      $image->create();
      $image->set('event_id', $event->get('event_id'));
      $image->set('mime_type_id', $mime_type->get('mime_type_id'));
      $image->set('image', $_FILES['image']['tmp_name']);
      $image->write(TRANSACTION);
      
    }
  } else if (isset($_POST['image_delete']) && $image->select(array('event_id' => $event->get('event_id')))) {
    $image->delete(TRANSACTION);
  }

  $attachment = new Event_Attachment;
  $mime_type = new MIME_Type;
  if (isset($_POST['attachment_upload']) && is_array($_POST['attachment_upload'])) {
    foreach($_POST['attachment_upload'] as $key => $value) {
      if ($_FILES["attachment_file_$key"]['size'] != 0)
      {
        if (! $mime_type->select(array('mime_type' => $_FILES["attachment_file_$key"]['type']))) {
          if ($_FILES["attachment_file_$key"]['type'] == "") {
            throw new Exception("empty mime-type.",1);
            echo "empty mime_type";
          }
          $mime_type->create();
          $mime_type->set('mime_type', $_FILES["attachment_file_$key"]['type']);
          $dot_position = strrpos($_FILES["attachment_file_$key"]['name'], '.');
          if ($dot_position === false) {
            throw new Exception("Invalid File Extension: {$_FILES["attachment_file$key"]['name']}");
          }
          $extension = substr($_FILES["attachment_file_$key"]['name'], $dot_position + 1);
          $mime_type->set('file_extension', strtolower($extension));
          $mime_type->set('f_image', 'f');
          $mime_type->write(TRANSACTION);
        }
        $attachment->create();
        $attachment->set('event_id', $event->get('event_id'));
        $attachment->set('attachment_type_id', $value['attachment_type_id']);
        $attachment->set('mime_type_id', $mime_type->get('mime_type_id'));
        $attachment->set('filename', $_FILES["attachment_file_$key"]['name']);
        $attachment->set('title', $value['title']);
        $attachment->set('f_public', isset($value['f_public']) ? 't' : 'f');
        $attachment->set('data', $_FILES["attachment_file_$key"]['tmp_name']);
        $attachment->write(TRANSACTION);
      }
    }
  }
  
  if (isset($_POST['attachment']) && is_array($_POST['attachment'])) {
    foreach($_POST['attachment'] as $attachment_id => $value) {
      if ($attachment->select(array('event_attachment_id' => $attachment_id)) == 1) {
        if (isset($value['delete']) && $value['delete'] == 't') {
          $attachment->delete(TRANSACTION);
        } else {
          $attachment->set('attachment_type_id', $value['attachment_type_id']);
          $attachment->set('title', $value['title']);
          $attachment->set('filename', $value['filename']);
          $attachment->set('f_public', isset($value['f_public']) ? 't' : 'f');
          $attachment->write(TRANSACTION);
        }
      }
    }
  }

  $event_keyword = new Event_Keyword;
  save_keyword($event_keyword, "event_id", $event->get('event_id'));
  
  // save information about related events
  if ( isset( $_POST['related_event'] ) && is_array( $_POST['related_event'] ) ) {
    $related_event = new Event_Related;
    foreach ( $_POST['related_event'] as $value ) {
      if ( isset($value['delete']) || 
           !isset($value['related_event_id']) ||
           $related_event->select(array('event_id1' => $event->get('event_id'), 'event_id2' => $value['related_event_id']))) {
         continue;
      }
      $related_event->create();
      $related_event->set('event_id1', $event->get('event_id'));
      $related_event->set('event_id2', $value['related_event_id']);
      $related_event->write(TRANSACTION);
    }
  }

  if ( isset( $_POST['related_event_delete'] ) && is_array( $_POST['related_event_delete'])) {
    $related_event = new Event_Related;
    foreach( $_POST['related_event_delete'] as $key => $value ) {
      if ($related_event->select(array('event_id1' => $event->get('event_id'), 'event_id2' => $key ) ) ) {
         $related_event->delete(TRANSACTION);
      }
    }
  }
  
  $transaction = new Event_Transaction;
  $transaction->create();
  $transaction->set('event_id', $event->get('event_id'));
  $transaction->set('changed_by', $transaction->get_auth_person_id());
  $transaction->set('f_create', $new_dataset ? TRUE : FALSE);
  $transaction->write(TRANSACTION);

  if ($new_dataset)
  {
    $watchlist = new Person_Watchlist_Event;
    $watchlist->create();
    $watchlist->set('person_id', $watchlist->get_auth_person_id());
    $watchlist->set('event_id', $event->get('event_id'));
    $watchlist->write(TRANSACTION);
  }

  $event->commit();
  header("Location: ".get_event_url($event));
  exit;

?>
