<?php

  require_once("../classes/jabber.php");
  require_once("../db/auth_person.php");

  // global array for collected error_messages
  $error_messages = array();

  // general error handler collecting all messages in an array
  function Error_Handler($error_number, $error_string, $error_file, $error_line, $error_context)
  {
    global $error_messages;
    array_push($error_messages, "Error Number: ".$error_number."\nError String: ".$error_string."\nError File: ".$error_file."\nError Line: ".$error_line."\n");
  }

  // register error handler
  set_error_handler("Error_Handler", E_ALL);


  // send errors 
  function send_errors()
  {
    global $error_messages;
    global $auth_person;

    if (!$error_messages) return;

    $url = "https://".$_SERVER["SERVER_NAME"].(dirname($_SERVER['SCRIPT_NAME'])!= "/" ? dirname($_SERVER['SCRIPT_NAME']) : "")."/pentabarf/".$_SERVER['QUERY_STRING'];

    $message = "";
    if (isset($_SERVER['PHP_AUTH_USER'])) {
      $message .= "Person: ".$_SERVER['PHP_AUTH_USER']."\n";
    }
    $message .= "URL: $url\n";
    if (isset($_SERVER['HTTP_USER_AGENT']) && strstr($_SERVER['HTTP_USER_AGENT'], 'Firefox') === false) {
      $message .= "UA: ".$_SERVER['HTTP_USER_AGENT']."\n";
    }
    if (isset($_SERVER['HTTP_REFERER'])) {
      $message .= "Referer: ".$_SERVER['HTTP_REFERER']."\n";
    }
    foreach($error_messages as $value)
    {
      $message .= $value."\n";
    }
    send_message($message);

    // display error messages on screen too for developers
    if ($auth_person instanceof Auth_Person && $auth_person->check_authorisation("show_debug")) 
    {
      echo "<pre id='error'>\n".$message."</pre>";
    }
  }

  register_shutdown_function("send_errors");

  // send jabber message and email
  function send_message(&$message)
  {
    chdir(dirname(__FILE__));
    require_once('../config/jabber.php');

    if (isset($jabber_recipient) && count($jabber_recipient)) {
      $jabber = new Jabber($server, $port, $username, $password, $resource);
      if ($jabber->Connect() && $jabber->SendAuth()) {
        foreach($jabber_recipient as $value)
        {
          $jabber->SendMessage($value, "normal", NULL, array("body" => $message, "subject" => "Error in Pentabarf"), NULL);
        }
        $jabber->Disconnect();
      } else {
        array_push($message, "Couldn't connect to Jabber Server.");
      }
    }

    if (isset($mail_recipient) && count($mail_recipient)) {
      foreach($mail_recipient as $to) {
        mail($to, isset($mail_subject) ? $mail_subject : "Pentabarf Error", $message);
      }
    }
  
  }


?>
