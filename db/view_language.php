<?php

  require_once('../db/view.php');

  class View_Language extends View
  {
  
    public function __construct($select = array())
    {
      $this->order = "f_preferred, name";
      $this->table = "language, language_localized";
      $this->join = "language.language_id = language_localized.translated_id";
      $this->field['translated_id']['type'] = 'SERIAL';
      $this->field['translated_id']['table'] = 'language_localized';
      $this->field['iso_639_code']['type'] = 'VARCHAR';
      $this->field['iso_639_code']['table'] = 'language';
      $this->field['tag']['type'] = 'VARCHAR';
      $this->field['tag']['table'] = 'language';
      $this->field['f_default']['type'] = 'BOOL';
      $this->field['f_default']['table'] = 'language';
      $this->field['f_localized']['type'] = 'BOOL';
      $this->field['f_localized']['table'] = 'language';
      $this->field['f_visible']['type'] = 'BOOL';
      $this->field['f_visible']['table'] = 'language';
      $this->field['f_preferred']['type'] = 'BOOL';
      $this->field['f_preferred']['table'] = 'language';
      $this->field['language_id']['type'] = 'INTEGER';
      $this->field['language_id']['table'] = 'language_localized';
      $this->field['name']['type'] = 'VARCHAR';
      $this->field['name']['table'] = 'language_localized';
      parent::__construct($select);
    }
  
  }


?>
