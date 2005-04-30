<?php

  require_once("../db/mime_type.php");


  /** Save a file from an upload in the database.
   *
   * @param $class Class to put the data in
   * @param $file  array with information of the file
   * @param $field_name Field name of the data in the database
   * @param $image do we want to store images (limits the allowed mime types)
  */

  function save_file($class, $file, $field_name, $image = true)
  {
    // trigger_error(print_r($file,true));
   
    if (!$file["size"] || !$file["tmp_name"]) return false;
    $mime_type = new Mime_Type;
    if ($mime_type->select(array('mime_type' => $file["type"])))
    { // mime type found
      if ($image && !$mime_type->get('f_image')) return false;
      $class->set_mime_type_id($mime_type->get('mime_type_id'));
      $file_handle = fopen($file["tmp_name"], "r");
      $data = fread($file_handle, $file["size"]);
      call_user_func(array($class, "set_$field_name"), $data);
      $class->write();
    } else {
      throw new Exception("MIME-Type not allowed: ".$file["type"], 1);
      return false;
    }
  }
 

  /** Function for saving links
   *
   * @param $class class of the table to save the links in.
   * @param $view View to save links in (conference/event/person).
   * @param $view_id id of the View the links belong to.
  */

  function save_link($class, $view, $view_id)
  {
    if (isset($_POST["link"]) && is_array($_POST["link"])) {
      foreach($_POST["link"] as $link) {
        if ($class->select(array("{$view}_link_id" => $link["link_id"])))
        if (isset($link["delete"]) && $class->get_count()) {
          $class->delete(TRANSACTION);
          continue;
        }
        if ($class->get_count() != 1) $class->create();
        if (!$link["url"]) continue;
        $class->set("{$view}_id", $view_id);
        $class->set('link_type_id', $link["link_type_id"]);
        $class->set('url', $link["url"]);
        $class->set('title', $link["title"]);
        $class->set('description', $link["description"]);
        $class->write(TRANSACTION);
      }
    }
  }


  /** Function for saving keywords
   *
   * @param $class
   * @param $id_name name of the id field
  */

  function save_keyword($class, $id_name, $object_id)
  {
    if(isset($_POST['keyword']) && is_array($_POST['keyword']) && isset($_POST[$id_name]))
    {
      $class->select(array($id_name => $object_id));
      foreach($class as $key) { 
        $class->delete(TRANSACTION);
      }

      $created = array();
      foreach($_POST['keyword'] as $value) {
        $class->clear();
        if (in_array($value['keyword_id'], $created)) continue;
        if (isset($value['delete'])) continue;
        $class->create();
        $class->set($id_name, $object_id);
        $class->set('keyword_id', $value['keyword_id']);
        $class->write(TRANSACTION);
        array_push($created, $value['keyword_id']);
      }
    }
  }


?>
