<?php

  require_once('../db/view.php');

  class View_Event_Role_State extends View
  {
  
    public function __construct($select = array())
    {
      $this->table = 'event_role_state, event_role_state_localized';
      $this->order = 'event_role_state.rank, event_role_state_localized.name';
      $this->join = 'event_role_state.event_role_state_id = event_role_state_localized.event_role_state_id';
      $this->field['event_role_state_id']['type'] = 'INTEGER';
      $this->field['event_role_state_id']['table'] = 'event_role_state';
      $this->field['event_role_id']['type'] = 'INTEGER';
      $this->field['event_role_id']['table'] = 'event_role_state';
      $this->field['tag']['type'] = 'VARCHAR';
      $this->field['tag']['table'] = 'event_role_state';
      $this->field['rank']['type'] = 'INTEGER';
      $this->field['rank']['table'] = 'event_role_state';
      $this->field['language_id']['type'] = 'INTEGER';
      $this->field['language_id']['table'] = 'event_role_state_localized';
      $this->field['name']['type'] = 'VARCHAR';
      $this->field['name']['table'] = 'event_role_state_localized';
      
      parent::__construct($select);
    }
  
  }

?>
