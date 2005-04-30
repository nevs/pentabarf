<?php

  
  function member_to_template($class, $except)
  {
    global $template;
    if (!$class->get_count()) return;
  
    foreach($class->get_field_names() as $value) {
      if (in_array($value, $except)) continue;
      switch ($class->get_type($value)) {
        case 'DATE': 
          $wert = !is_object($class->get($value)) ? "" : $class->get($value)->format("%Y-%m-%d");
          $template->addVar("content",strtoupper($value), $wert);
          break;
        case 'TIME': case 'INTERVAL':
          $wert = !is_object($class->get($value)) ? "" : $class->get($value)->format("%H:%M:%S");
          $template->addVar("content",strtoupper($value), $wert);
          break;
        case 'DATETIME': case 'TIMESTAMP':
          $wert = !is_object($class->get($value)) ? "" : $class->get($value)->format("%Y-%m-%d %H:%M:%S");
          $template->addVar("content",strtoupper($value), $wert);
          break;
        default:
          $template->addVar("content",strtoupper($value),$class->get($value));
      }
    }
  }

?>
