<?php

require_once('view.php');

/**
 * Class for accessing, manipulating, creating and deleting records in im_type.
*/

class View_IM_Type extends View 
{

  public function __construct($select = array())
  {
    $this->table = 'im_type, im_type_localized';
    $this->order = 'im_type.rank';
    $this->domain = 'valuelist';
    $this->join = 'im_type.im_type_id = im_type_localized.im_type_id AND im_type_localized.language_id = {$this->get_language_id()}';

    $this->field['im_type_id']['type'] = 'INTEGER';
    $this->field['im_type_id']['table'] = 'im_type';
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['table'] = 'im_type';
    $this->field['scheme']['type'] = 'VARCHAR';
    $this->field['scheme']['table'] = 'im_type';
    $this->field['rank']['type'] = 'INTEGER';
    $this->field['rank']['table'] = 'im_type';
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['table'] = 'im_type_localized';
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['table'] = 'im_type_localized';
    parent::__construct($select);
  }

}

?>
