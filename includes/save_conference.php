<?php

  require_once('../db/conference.php');
  require_once('../db/conference_track.php');
  require_once('../db/person_watchlist_conference.php');
  require_once('../db/conference_link.php');
  require_once('../db/conference_transaction.php');
  require_once('../db/conference_image.php');
  require_once('../db/room.php');
  require_once('../db/conference_person.php');
  require_once('../db/team.php');
  require_once('../functions/save-common.php');

  if (!$new_dataset){
    $transaction = new Conference_Transaction;
    if ( $transaction->select( array( 'conference_id' => $_POST['conference_id'] ) ) &&
         $transaction->get('changed_when') != $_POST['timestamp'] ) {
      trigger_error('Outdated data');
      die('Outdated data');
    }
  }

  $conference = new Conference;
  $conference->begin();
  if ($conference->select(array('conference_id' => $_POST['conference_id'])) != 1) {
    $conference->create();
  }
  foreach($conference->get_field_names() as $value) {
    if ($value == 'conference_id') continue;
    if (isset($_POST[$value])) {
      $conference->set($value, $_POST[$value]);
    }
  }
  $conference->write(TRANSACTION);


  $track = new Conference_Track;
  if (isset($_POST['conference_track_tag']) && is_array($_POST['conference_track_tag'])) {
    foreach($_POST['conference_track_tag'] as $key => $value) {
      $track->clear();
      if (isset($_POST['delete_conference_track'][$key])) {
        // delete conference track
        if ($track->select(array('conference_track_id' => $_POST['conference_track_id'][$key])) == 1 ) {
          $track->delete(TRANSACTION);
        }
        continue;
      } else {
        if ($value === "") continue;
        if ($track->select(array('conference_track_id' => $_POST['conference_track_id'][$key])) != 1) {
          $track->create();
        }
        $track->set('conference_id', $conference->get('conference_id'));
        $track->set('tag', $value);
        $track->write(TRANSACTION);
      }
    }
  }

  if (isset($_POST['team']) && is_array($_POST['team'])) {
    foreach($_POST['team'] as $value) {
      if (!isset( $value['tag'])) continue;
      $team = new Team;
      if ($team->select(array('team_id' => $value['team_id'])) == 1) {
        if (isset($value['delete'])) {
          $team->delete(TRANSACTION);
          continue;
        }
      } else if (isset($value['delete'])) {
        continue;
      } else {
        $team->create();
      }
      $team->set('conference_id', $conference->get('conference_id'));
      $team->set('tag', $value['tag']);
      $team->write(TRANSACTION);
    }
  
  }

  
  $conference_link = new Conference_Link;
  save_link($conference_link, "conference", $conference->get('conference_id'));

  $image = new Conference_Image;
  $mime_type = new MIME_Type;
  if (isset($_FILES["image"]) && $_FILES['image']['size'] != 0)
  {
    if ($mime_type->select(array('mime_type' => $_FILES['image']['type'], 'f_image' => 't')) != 1) {
      throw new Exception("Unsupported MIME_Type: {$_FILES['image']['type']}");
    } else {
      if ($image->select(array('conference_id' => $conference->get('conference_id'))) == 1) {
        $image->delete(TRANSACTION);
      }
      $image->create();
      $image->set('conference_id', $conference->get('conference_id'));
      $image->set('mime_type_id', $mime_type->get('mime_type_id'));
      $image->set('image', $_FILES['image']['tmp_name']);
      $image->write(TRANSACTION);
      
    }
  } else if (isset($_POST['image_delete']) && $image->select(array('conference_id' => $conference->get('conference_id')))) {
    $image->delete(TRANSACTION);
  }

  $room = new Room;
  if (isset($_POST["room"]) && is_array($_POST["room"])) 
  {
    foreach($_POST["room"] as $key => $value)
    {
      $room->clear();
      if ($room->select(array('room_id' => $value["room_id"])) != 1) {
        if (isset($value["delete"])) { continue; }
        $room->create();
      } else if (isset($value["delete"])) {
        $room->delete(TRANSACTION);
        continue;
      }
      foreach($room->get_field_names() as $field)
      {
        if ($field == "room_id" || $field == "f_public") continue;
        if (isset($value[$field])) $room->set($field, $value[$field]);
      }
      $room->set('conference_id', $conference->get('conference_id'));
      $room->set('f_public', isset($value["f_public"])? 't' : 'f');
      $room->write(TRANSACTION);
    }
  }


  $person = new Conference_Person;
  if (isset($_POST["conference_person"]) && is_array($_POST["conference_person"]))
  {
    foreach($_POST["conference_person"] as $value)
    {
      if (isset($value['conference_person_id']) && 
          $person->select(array('conference_id' => $conference->get('conference_id'), 
                          'conference_person_id' => $value['conference_person_id'])) == 1)
      {
        if (isset($value['delete'])) {
          $person->delete(TRANSACTION);
          continue;
        }
      } else {
        if (isset($value["delete"])) {
          continue; 
        } else {
          $person->create();
        }
      }
      $person->set('conference_id', $conference->get('conference_id'));
      $person->set('person_id', $value["person_id"]);
      $person->set('conference_role_id', $value["conference_role_id"]);
      $person->set('remark', $value["remark"]);
      $person->write(TRANSACTION);
    }
  }
  
  $transaction = new Conference_Transaction;
  $transaction->create();
  $transaction->set('conference_id', $conference->get('conference_id'));
  $transaction->set('changed_by', $transaction->get_auth_person_id());
  $transaction->set('f_create', $new_dataset ? "t" : "f");
  $transaction->write(TRANSACTION);


  if ($new_dataset)
  {
    $watchlist = new Person_Watchlist_Conference;
    $watchlist->create();
    $watchlist->set('person_id', $watchlist->get_auth_person_id());
    $watchlist->set('conference_id', $conference->get('conference_id'));
    $watchlist->write(TRANSACTION);
  }

  
  $conference->commit();
  header("Location: ".get_conference_url($conference));
  exit;

?>
