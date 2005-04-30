<?php

require_once("entity.php");
require_once("language.php");

/**
 * Class that handles user-authentication. You only have to include
 * this file if you need authentication in your script.
*/
class Auth_Public extends Entity {

  /**
   * Constructor of the class.
  */
  public function __construct()
  {
    $this->domain = "person";
    parent::__construct();
    // get language for the application
    $language = new Language;
  
    if (isset($_SERVER['HTTP_ACCEPT_LANGUAGE']))
    {
      foreach(explode(",",$_SERVER['HTTP_ACCEPT_LANGUAGE']) as $tag){
        $tag = strtok($tag, ";");
        if ($language->select(array('tag' => strtok($tag, "-"))) == 1 || 
            $language->select(array('tag' => $tag)) == 1) {
          break;
        } 
      }
    }
    if ($language->get_count() || $language->select(array('f_default' => 't'))) {
      $this->data[0]['preferences']['language'] = $language->get('language_id');
      $this->set_language_id($language->get('language_id'));
      if ($this->check_authorisation("modify_own_person")) {
        $this->write();
      }
    } else throw new Exception("no default language available",1);
  }

  final public function get($field_name)
  {
    throw new Exception("You are not allowed to get this.", 1);
  }

  final public function set($field_name, $value)
  {
    throw new Exception("You are not allowed to set this",1);
  }

}

?>
