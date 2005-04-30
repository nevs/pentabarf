<?php

  require_once('../classes/database/db_base.php');
  require_once('../classes/database/datatypes/dt_integer.php');
  require_once('../classes/database/datatypes/dt_varchar.php');
  require_once('../classes/database/datatypes/dt_char.php');
  require_once('../classes/database/datatypes/dt_text.php');
  require_once('../classes/database/datatypes/dt_preferences.php');
  require_once('../classes/database/tables/language.php');

  class Auth_Person extends DB_Base
  {
    public function __construct()
    {
      parent::__construct();

      $this->table = 'person';
      $this->domain = 'person';

      $this->fields['person_id'] = new DT_INTEGER( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true));
      $this->fields['login_name'] = new DT_VARCHAR( $this, 'login_name', array('length' => 32), array('NOT_NULL' => true) );
      $this->fields['password'] = new DT_CHAR( $this, 'password', array('length' => 48), array('NOT_NULL' => true) );
//      $this->fields['name'] = new DT_TEXT( $this, 'name', array(), array() );
      $this->fields['preferences'] = new DT_PREFERENCES( $this, 'preferences', array(), array() );

      if (isset($_SERVER['PHP_AUTH_USER']) && $_SERVER['PHP_AUTH_USER'] && isset($_SERVER['PHP_AUTH_PW']) && $_SERVER['PHP_AUTH_PW']) {
        if ($this->select(array('login_name' => $_SERVER['PHP_AUTH_USER'], 'password' => true)) == 1 && strlen($this->data[0]['password']->get() ) == 48) {
          $salt = substr($this->data[0]['password']->get(), 0, 16);
          if ($this->data[0]['password']->get() === $salt.bin2hex(mhash_keygen_s2k(MHASH_MD5,$_SERVER['PHP_AUTH_PW'], pack("H16",$salt), 16))) {
            $this->set_auth_person_id($this->get('person_id'));
            $this->set_auth_login_name($this->get('login_name'));
            $this->get_permissions();
            if ($this->check_authorization("login_allowed"))
            {
              $this->query("UPDATE person SET last_login = now() WHERE person_id = {$this->data[0]['person_id']->get()}");
              $preferences = $this->data[0]['preferences']->get();
              if (isset($preferences['language'])) { 
                $this->set_auth_language_id($preferences['language']);
              }
              // get language for the application
              if (!$preferences['language'])
              {
                $language = new LANGUAGE;
              
                if ( isset( $_SERVER['HTTP_ACCEPT_LANGUAGE'] ) )
                {
                  foreach(explode(",",$_SERVER['HTTP_ACCEPT_LANGUAGE']) as $tag){
                    $tag = strtok($tag, ";");
                    if ( $language->select( array( 'tag' => strtok( $tag, "-" ) ) ) == 1 || 
                         $language->select( array( 'tag' => $tag ) ) == 1 )
                    {
                      break;
                    } 
                  }
                }
                if ( $language->get_count() || $language->select( array( 'f_default' => 't' ) ) ) {
                  $preferences['language'] = $language->get( 'language_id' );
                  $this->set_auth_language_id($language->get('language_id'));
                  $this->data[0]['preferences']->set($preferences );
                  if ($this->check_authorization("modify_own_person")) {
                    $this->write();
                  }
                } else throw new Exception("no default language available",1);
              }
  
              return;
            } else {
              trigger_error("Login not allowed\nUser: ".$_SERVER['PHP_AUTH_USER']);
            }
          }
        }
      }
      header('WWW-Authenticate: Basic realm="Pentabarf"');
      header('HTTP/1.0 401 Unauthorized');
      echo "You are not authorized to view these pages.";
      exit;
    }
  
  }

?>
