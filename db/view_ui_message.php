<?PHP

  require_once('../db/view.php');
  
class View_UI_Message extends View {

  public function __construct($select = array())
  {
    $this->table = "ui_message, ui_message_localized";
    $this->order = "";
    $this->domain = "localization";
    $this->join = "ui_message.ui_message_id = ui_message_localized.ui_message_id";
    $this->field['ui_message_id']['type'] = 'INTEGER';
    $this->field['ui_message_id']['table'] = 'ui_message';
    $this->field['tag']['type'] = 'VARCHAR';
    $this->field['tag']['table'] = 'ui_message';
    $this->field['language_id']['type'] = 'INTEGER';
    $this->field['language_id']['table'] = 'ui_message_localized';
    $this->field['name']['type'] = 'VARCHAR';
    $this->field['name']['table'] = 'ui_message_localized';
    parent::__construct($select);
  }

}


?>
