<?php

require_once('view.php');

/**
 * Class for accessing, manipulating, creating and deleting records in event_link.
*/

class View_Event_Link extends View 
{

  public function __construct($select = array())
  {
    $this->table = 'event_link, link_type, link_type_localized';
    $this->order = '';
    $this->join = "event_link.link_type_id = link_type.link_type_id AND event_link.link_type_id = link_type_localized.link_type_id AND link_type_localized.language_id = {$this->get_language_id()}";
    $this->domain = 'event';
    $this->field['event_link_id']['type'] = 'SERIAL';
    $this->field['event_link_id']['table'] = 'event_link';
    $this->field['event_id']['type'] = 'INTEGER';
    $this->field['event_id']['table'] = 'event_link';
    $this->field['link_type_id']['type'] = 'INTEGER';
    $this->field['link_type_id']['table'] = 'event_link';
    $this->field['url']['type'] = 'VARCHAR';
    $this->field['url']['table'] = 'event_link';
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['table'] = 'event_link';
    $this->field['description']['type'] = 'VARCHAR';
    $this->field['description']['table'] = 'event_link';
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['rank']['table'] = 'event_link';
    $this->field['f_public']['type'] = 'BOOL';
    $this->field['f_public']['table'] = 'link_type';
    $this->field['link_type']['type'] = 'VARCHAR';
    $this->field['link_type']['name'] = 'link_type_localized.name';
    $this->field['link_type_tag']['type'] = 'VARCHAR';
    $this->field['link_type_tag']['name'] = 'link_type.tag';
    parent::__construct($select);
  }

}

?>
