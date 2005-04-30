<?php

require_once('view.php');

/**
 * Class for accessing, manipulating, creating and deleting records in person_link.
*/

class View_Person_Link extends View
{

  public function __construct($select = array())
  {
    $this->table = 'person_link, link_type, link_type_localized';
    $this->order = '';
    $this->join = "person_link.link_type_id = link_type.link_type_id AND person_link.link_type_id = link_type_localized.link_type_id AND link_type_localized.language_id = {$this->get_language_id()}";
    $this->domain = 'person';
    $this->field['person_link_id']['type'] = 'SERIAL';
    $this->field['person_link_id']['table'] = 'person_link';
    $this->field['person_id']['type'] = 'INTEGER';
    $this->field['person_id']['table'] = 'person_link';
    $this->field['link_type_id']['type'] = 'INTEGER';
    $this->field['link_type_id']['table'] = 'person_link';
    $this->field['url']['type'] = 'VARCHAR';
    $this->field['url']['table'] = 'person_link';
    $this->field['title']['type'] = 'VARCHAR';
    $this->field['title']['table'] = 'person_link';
    $this->field['description']['type'] = 'VARCHAR';
    $this->field['description']['table'] = 'person_link';
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['rank']['table'] = 'person_link';
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
