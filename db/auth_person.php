<?php

require_once("entity.php");
require_once("language.php");

/**
 * Class that handles user-authentication. You only have to include
 * this file if you need authentication in your script.
*/
class Auth_Person extends Entity {

  /**
   * Constructor of the class.
  */
  public function __construct()
  {
    $this->table = "person";
    $this->domain = "person";
    $this->field['person_id']['type'] = 'SERIAL';
    $this->field['person_id']['not_null'] = true;
    $this->field['person_id']['primary_key'] = true;
    $this->field['login_name']['type'] = 'VARCHAR';
    $this->field['login_name']['length'] = 32;
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['name'] = 'coalesce(person.public_name, coalesce(person.first_name || \' \', \'\') || person.last_name, person.nickname, person.login_name)';
    $this->field['password']['type'] = 'CHAR';
    $this->field['password']['length'] = 48;
    $this->field['preferences']['type'] = 'PREFERENCES';
    parent::__construct();
    if (isset($_SERVER['PHP_AUTH_USER']) && $_SERVER['PHP_AUTH_USER'] && isset($_SERVER['PHP_AUTH_PW']) && $_SERVER['PHP_AUTH_PW']) {
      if ($this->select(array('login_name' => $_SERVER['PHP_AUTH_USER'], 'password' => true)) == 1 && strlen($this->data[0]['password']) == 48) {
        $salt = substr($this->data[0]['password'], 0, 16);
        if ($this->data[0]['password'] === $salt.bin2hex(mhash_keygen_s2k(MHASH_MD5,$_SERVER['PHP_AUTH_PW'], pack("H16",$salt), 16))) {
          $this->set_auth_person_id($this->data[0]['person_id']);
          $this->set_auth_login_name($this->data[0]['login_name']);
          $this->get_permissions();
          if ($this->check_authorisation("login_allowed"))
          {
            $this->query("UPDATE person SET last_login = now() WHERE person_id = {$this->data[0]['person_id']}");
            if (isset($this->data[0]['preferences']['language'])) { 
              $this->set_language_id($this->data[0]['preferences']['language']);
            }
            // get language for the application
            if (!$this->data[0]['preferences']['language'])
            {
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

            return;
          } else {
            trigger_error("Login not allowed\nUser: ".$_SERVER['PHP_AUTH_USER']);
          }
        } else {
           trigger_error("Wrong password for user ".$_SERVER['PHP_AUTH_USER']);
        }
      } else {
         trigger_error("User does not exist: ".$_SERVER['PHP_AUTH_USER']);
      }
    }
    header('WWW-Authenticate: Basic realm="Pentabarf"');
    header('HTTP/1.0 401 Unauthorized');
    echo "You are not authorized to view these pages.";
    exit;
  }

  final public function get( $field_name )
  {
    if (in_array($field_name, array("person_id", "login_name", "preferences", "name"))) {
      return Entity::get($field_name);
    } else {
      throw new Exception("You are not allowed to get this.", 1);
    }
  }

  final public function set( $field_name, $value )
  {
    if ($field_name != "preferences") {
      throw new Exception("You are not allowed to set this",1);
    } else {
      return Entity::set($field_name, $value);
    }
  }

}

?>
