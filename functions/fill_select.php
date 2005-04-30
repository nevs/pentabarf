<?php

/**
 * Preprocess data from database and put it into the template
 *
 * @param $tmpl name of the template
 * @param $class reference to the class with the data
 * @param $value fieldname of the value field
 * @param $text fieldname of the text field
 * @param $selected value of the selected element
 * @param $with_empty add empty element is first entry
*/

function fill_selector($tmpl, $class, $value, $text, $selected, $current)
{
  global $template;
  $values = array();

  $is_in = false;
  foreach($class as $key) {
    if ($class->get($value) == $current->get($value)) $is_in = true;
    array_push($values, array(
        'VALUE'    => $class->get($value),
        'TEXT'     => $class->get($text),
        'SELECTED' => $class->get($value) == $selected ? "selected='selected'" : ""
      ));
  }
  if (!$is_in)
  {
    array_unshift($values, array('TEXT' => "-------------"));
    array_unshift($values, array(
        'VALUE'    => $current->get($value),
        'TEXT'     => $current->get($text),
        'SELECTED' => $current->get($value) == $selected ? "selected='selected'" : ""
      ));
  }
  $template->addRows($tmpl, $values);
}

function fill_select($tmpl, $class, $value, $text, $selected, $with_empty = TRUE)
{
  global $template;

  $values = array();
  if ($with_empty) {
    array_push($values, array('VALUE' => 0, 'TEXT' => ""));
  }

  foreach($class as $key) {
    array_push($values, array(
        'VALUE'    => $class->get($value),
        'TEXT'     => $class->get($text),
        'SELECTED' => $class->get($value) == $selected ? "selected='selected'" : ""
      ));
  }
  $template->addRows($tmpl, $values);
}

?>
