<?php

/** 
 * Calculate Summary of Rating and put the result in the template
 *
 * @param $name name of the rating
 * @param $class class containing the results
 * @param $function function to call to get the value
*/


function rating_summary($name, $class, $function)
{
  global $template;

  $votes = 0;
  $sum = 0;
  foreach($class as $key) {
    if ($class->get($function)) {
      $votes++;
      $sum += $class->get($function) - 3;
    }
  }
  if ($sum) {
    $sum = round($sum*5/$votes) * 10;
    $template->addVar("content",$sum > 0 ? $name."_VALUE_POSITIVE" : $name."_VALUE_NEGATIVE", $sum);
  }

  $template->addVar("content",$name."_BAR_POSITIVE", $sum > 0 ? $sum : "0");
  $template->addVar("content",$name."_BAR_NEGATIVE", $sum < 0 ? abs($sum) : "0");
  $template->addVar("content",$name."_VOTE_COUNT",$votes);

}


?>
