<?php

require_once('../classes/database/db_base.php');
require_once('../classes/database/datatypes/dt_char.php');
require_once('../classes/database/datatypes/dt_varchar.php');
require_once('../classes/database/datatypes/dt_integer.php');
require_once('../classes/database/datatypes/dt_text.php');
require_once('../classes/database/datatypes/dt_serial.php');
require_once('../classes/database/datatypes/dt_timestamp.php');
require_once('../classes/database/datatypes/dt_bool.php');

/// class for accessing and manipulating content of table person
class PERSON extends DB_BASE
{
   /// constructor of the class person
   public function __construct()
   {
      parent::__construct();
      $this->table = 'person';
      $this->domain = 'person';
      $this->limit = 0;
      $this->order = '';

      $this->fields['last_login'] = new DT_TIMESTAMP( $this, 'last_login', array(), array() );
      $this->fields['f_deleted'] = new DT_BOOL( $this, 'f_deleted', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['f_conflict'] = new DT_BOOL( $this, 'f_conflict', array(), array('DEFAULT' => true, 'NOT_NULL' => true) );
      $this->fields['city'] = new DT_VARCHAR( $this, 'city', array('length' => 64), array() );
      $this->fields['gpg_key'] = new DT_TEXT( $this, 'gpg_key', array(), array() );
      $this->fields['account_owner'] = new DT_VARCHAR( $this, 'account_owner', array('length' => 128), array() );
      $this->fields['po_box_postcode'] = new DT_VARCHAR( $this, 'po_box_postcode', array('length' => 10), array() );
      $this->fields['public_name'] = new DT_VARCHAR( $this, 'public_name', array('length' => 64), array() );
      $this->fields['preferences'] = new DT_TEXT( $this, 'preferences', array(), array() );
      $this->fields['abstract'] = new DT_TEXT( $this, 'abstract', array(), array() );
      $this->fields['street_postcode'] = new DT_VARCHAR( $this, 'street_postcode', array('length' => 10), array() );
      $this->fields['title'] = new DT_VARCHAR( $this, 'title', array('length' => 32), array() );
      $this->fields['bank_name'] = new DT_VARCHAR( $this, 'bank_name', array('length' => 128), array() );
      $this->fields['nickname'] = new DT_VARCHAR( $this, 'nickname', array('length' => 64), array() );
      $this->fields['remark'] = new DT_TEXT( $this, 'remark', array(), array() );
      $this->fields['country_id'] = new DT_INTEGER( $this, 'country_id', array(), array() );
      $this->fields['po_box'] = new DT_VARCHAR( $this, 'po_box', array('length' => 10), array() );
      $this->fields['email_public'] = new DT_VARCHAR( $this, 'email_public', array('length' => 64), array() );
      $this->fields['gender'] = new DT_BOOL( $this, 'gender', array(), array() );
      $this->fields['login_name'] = new DT_VARCHAR( $this, 'login_name', array('length' => 32), array() );
      $this->fields['description'] = new DT_TEXT( $this, 'description', array(), array() );
      $this->fields['iban'] = new DT_VARCHAR( $this, 'iban', array('length' => 128), array() );
      $this->fields['email_contact'] = new DT_VARCHAR( $this, 'email_contact', array('length' => 64), array() );
      $this->fields['street'] = new DT_VARCHAR( $this, 'street', array('length' => 64), array() );
      $this->fields['first_name'] = new DT_VARCHAR( $this, 'first_name', array('length' => 64), array() );
      $this->fields['address'] = new DT_VARCHAR( $this, 'address', array('length' => 64), array() );
      $this->fields['last_name'] = new DT_VARCHAR( $this, 'last_name', array('length' => 64), array() );
      $this->fields['password'] = new DT_CHAR( $this, 'password', array('length' => 48), array() );
      $this->fields['person_id'] = new DT_SERIAL( $this, 'person_id', array(), array('NOT_NULL' => true, 'PRIMARY_KEY' => true) );
      $this->fields['middle_name'] = new DT_VARCHAR( $this, 'middle_name', array('length' => 64), array() );
   }

}

?>
