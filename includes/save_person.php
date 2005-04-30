<?php

  require_once('../db/person.php');
  require_once('../db/person_im.php');
  require_once('../db/person_phone.php');
  require_once('../db/person_travel.php');
  require_once('../db/person_rating.php');
  require_once('../db/person_role.php');
  require_once('../db/person_language.php');
  require_once('../db/person_watchlist_person.php');
  require_once('../db/event_person.php');
  require_once('../db/person_link.php');
  require_once('../db/person_transaction.php');
  require_once('../db/person_image.php');
  require_once('../db/person_keyword.php');
  require_once('../functions/save-common.php');
  
  if (!$new_dataset){
    $transaction = new Person_Transaction;
    if ( $transaction->select(array('person_id' => $_POST['person_id'])) &&
         $transaction->get('changed_when') != $_POST['timestamp']) {
      trigger_error('Outdated data');
      die('Outdated data');
    }
  }

  $person = new Person;
  $person->begin();
  if (intval($_POST['person_id'])) {
    $person->select(array('person_id' => $_POST['person_id']));
  } else {
    $person->create();
  }

  if($_POST['password1'] != '' && $_POST['password2'] != ''){
    if($_POST['password1'] == $_POST['password2'])
    {
      $person->set('password', $_POST['password1']);
    }else {
      die ('Passwoerter matchen nicht'); 
    }
  }

  $user_prefs = $person->get('preferences');
  
  if (isset($_POST['change_conference'])) {
    $user_prefs['conference'] = $_POST['conference'];
    $person->set('preferences', $user_prefs);
  }


  if (isset($_POST['change_language'])) {
    $user_prefs['language'] = $_POST['change_language'] ? $_POST['change_language'] : 0;
  }
  $user_prefs['images']['person'] = isset($_POST['pref_images_person']) ? true : false;
  $user_prefs['images']['event'] = isset($_POST['pref_images_event']) ? true : false;
  $user_prefs['images']['conference'] = isset($_POST['pref_images_conference']) ? true : false;

  if (isset($preferences['conference']) && $preferences['conference'] != 0 && (!isset($user_prefs['conference']) || (isset($user_prefs['conference']) && $user_prefs['conference'] == 0 ))) {
     $user_prefs['conference'] = $preferences['conference'];
  }

  $person->set('preferences', $user_prefs);

  foreach($person->get_field_names() as $value) {
    if ($value == 'person_id' || $value == 'password' || $value == 'f_conflict' || $value == 'last_login' || $value == 'f_deleted') continue;
    if (isset($_POST[$value])) {
      $person->set($value, $_POST[$value]);
    }
  }
  $person->set('f_conflict', isset($_POST['f_conflict']) ? 't' : 'f');
  $person->set('f_deleted', isset($_POST['f_deleted']) ? 't' : 'f');
  $person->write(TRANSACTION);

 
  $person_im = new Person_IM;
  if (isset($_POST['person_im']) && is_array($_POST['person_im'])) {
    foreach ($_POST['person_im'] as $key => $value) {
      $person_im->clear();
      if (!isset($value['im_address']) || !$value['im_address']) continue;
      if (isset($value['delete'])) {
        // delete person_im
        if ($value['person_im_id'] && $person_im->select(array('person_im_id' => $value['person_im_id']))) {
          $person_im->delete(TRANSACTION);
        }
        continue;
      } else {
        if ($person_im->select(array('person_im_id' => $value['person_im_id'])) != 1) {
          $person_im->create();
        }
        $person_im->set('im_type_id', $value['im_type_id']); 
        $person_im->set('person_id', $person->get('person_id'));
        $person_im->set('im_address', $value['im_address']);
        $person_im->write(TRANSACTION);
      }
    }
  }

  
  $person_phone = new Person_Phone;
  if (isset($_POST['phone_type_id']) && is_array($_POST['phone_type_id'])) {
    foreach($_POST['phone_type_id'] as $key => $value) {
      $person_phone->clear();
      if (!isset($_POST['phone_number'][$key]) || !$_POST['phone_number'][$key]) continue;
      if (isset($_POST['delete_number'][$key])) {
        // delete person_phone
        if ($_POST['person_phone_id'][$key] && $person_phone->select(array('person_phone_id' => $_POST['person_phone_id'][$key]))) {
          $person_phone->delete();
        }
      } else {
        if (!($_POST['person_phone_id'][$key] && $person_phone->select(array('person_phone_id' => $_POST['person_phone_id'][$key])) == 1)) {
          $person_phone->create();
        }
        $person_phone->set('person_id', $person->get('person_id'));
        $person_phone->set('phone_type_id', $value);
        $person_phone->set('phone_number', $_POST['phone_number'][$key]);
        $person_phone->write(TRANSACTION);
      }
    }
  }


  $person_language = new Person_Language;
  if ($person_language->select(array('person_id' => $person->get('person_id')))) {
    foreach($person_language as $key) {
      $person_language->delete(TRANSACTION);
    }
  }
  if (isset($_POST['spoken_language_id']) && is_array($_POST['spoken_language_id'])) {
    $created_language = array();
    foreach($_POST['spoken_language_id'] as $key => $value) {
      if (isset($_POST['delete_language'][$key])) continue;
      if (in_array($value, $created_language)) continue;
      $new_language = new Person_Language;
      $new_language->create();
      $new_language->set('person_id', $person->get('person_id'));
      $new_language->set('language_id', $value);
      $new_language->write(TRANSACTION);
      array_push($created_language, $value);
    }
  }

  $person_travel = new Person_Travel;
  if ($preferences['conference']) {
    if (!$person_travel->select(array('person_id' => $person->get('person_id'),'conference_id' => $preferences['conference']))) {
      $person_travel->create();
      $person_travel->set('conference_id', $preferences['conference']);
      $person_travel->set('person_id', $person->get('person_id'));
    }
    foreach($person_travel->get_field_names() as $value) {
      if ($value == 'conference_id' || $value == 'person_id' || $value == 'f_arrival_pickup' || $value == 'f_departure_pickup') continue;
      if (isset($_POST[$value])) {
        $person_travel->set($value, $_POST[$value]);
      }
    }
    $person_travel->set('f_arrival_pickup', isset($_POST['f_arrival_pickup']) ? 't' : 'f');
    $person_travel->set('f_departure_pickup', isset($_POST['f_departure_pickup']) ? 't' : 'f');
    $person_travel->set('f_arrived', isset($_POST['f_arrived']) ? 't' : 'f');
    $person_travel->write(TRANSACTION);
  }

  $person_rating = new Person_Rating;
  $person_rating->select(array('person_id' => $person->get('person_id'), 'evaluator_id' => $person->get_auth_person_id()));
  if (!$person_rating->get_count()) $person_rating->create();
  $person_rating->set('person_id', $person->get('person_id'));
  $person_rating->set('evaluator_id', $person_rating->get_auth_person_id());
  foreach($person_rating->get_field_names() as $value) {
    if ($value == 'person_id' || $value == 'evaluator_id' || $value == 'remark') continue;
    if (isset($_POST[$value])) {
      $person_rating->set($value, $_POST[$value]);
    }
  }
  $person_rating->set('remark', $_POST['rating_remark']);
  $person_rating->write(TRANSACTION);

  if (isset($_POST['role']) && is_array($_POST['role']) && $person->check_authorisation('modify_login'))
  {
    $person_role = new Person_Role;
    if ($person_role->select(array('person_id' => $person->get('person_id')))) {
      foreach($person_role as $key) {
        $person_role->delete(TRANSACTION);
      }
    }
    foreach($_POST['role'] as $key => $value) {
      $new_role = new Person_Role;
      $new_role->create();
      $new_role->set('person_id', $person->get('person_id'));
      $new_role->set('role_id', $key);
      $new_role->write(TRANSACTION);
    }
  }

 

  $event_person = new Event_Person;
  if (isset($_POST['event_person']) && is_array($_POST['event_person'])) {
    $created = array();
    foreach($_POST['event_person'] as $key => $value ) {
      if (!isset( $value['event_id'])) continue;
      $event_person->clear();
      if (in_array($value['event_id'].':'.$value['event_role_id'], $created)) continue;
      if (!$event_person->select(array('event_person_id' => $value['event_person_id']))) {
        $event_person->create();
      }
      if (isset($value['delete'])) {
        if ($event_person->get('event_person_id')) $event_person->delete(TRANSACTION);
        continue;
      }
      $event_person->set('event_id', $value['event_id']);
      $event_person->set('person_id', $person->get('person_id'));
      $event_person->set('event_role_id', $value['event_role_id']);
      $event_person->set('event_role_state_id', isset($value['event_role_state_id']) ? $value['event_role_state_id'] : 0);
      $event_person->set('remark', $value['remark']);
      $event_person->write(TRANSACTION);
      array_push($created, $value['event_id'].':'.$value['event_role_id']);
    }
  }


  $person_link = new Person_Link;
  save_link($person_link, 'person', $person->get('person_id'));


  $person_keyword = new Person_Keyword;
  save_keyword($person_keyword, 'person_id', $person->get('person_id'));
  

  $image = new Person_Image;
  $mime_type = new MIME_Type;
  if (isset($_FILES['image']) && $_FILES['image']['size'] != 0)
  {
    if ($mime_type->select(array('mime_type' => $_FILES['image']['type'], 'f_image' => 't')) != 1) {
      throw new Exception("Unsupported MIME_Type: {$_FILES['image']['type']}");
    } else {
      if ($image->select(array('person_id' => $person->get('person_id'))) == 1) {
        $image->delete(TRANSACTION);
      }
      $image->create();
      $image->set('person_id', $person->get('person_id'));
      $image->set('mime_type_id', $mime_type->get('mime_type_id'));
      $image->set('f_public', isset($_POST['image_public']) ? 't' : 'f');
      $image->set('image', $_FILES['image']['tmp_name']);
      $image->write(TRANSACTION);
    }
  } else if ($image->select(array('person_id' => $person->get('person_id')))) {
    if (isset($_POST['image_delete']) && $_POST['image_delete'] == 't') {
      $image->delete(TRANSACTION);
    } else {
      $image->set('f_public', isset($_POST['image_public']) ? 't' : 'f');
      $image->write(TRANSACTION);
    }
  }


  $transaction = new Person_Transaction;
  $transaction->create();
  $transaction->set('person_id', $person->get('person_id'));
  $transaction->set('changed_by', $transaction->get_auth_person_id());
  $transaction->set('f_create', $new_dataset ? 't' : 'f');
  $transaction->write(TRANSACTION);


  if ($new_dataset)
  {
    $watchlist = new Person_Watchlist_Person;
    $watchlist->create();
    $watchlist->set('person_id', $watchlist->get_auth_person_id());
    $watchlist->set('watched_person_id', $person->get('person_id'));
    $watchlist->write(TRANSACTION);
  }

  
  $person->commit();
  header("Location: ".get_person_url($person));
  exit;

?>
