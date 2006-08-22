// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function clear_tainting()
{
  window.onbeforeunload = null;
}

function enable_save_button()
{
  $('buttons').style.display = 'block';
  window.onbeforeunload = unloadMessage;
}

function unloadMessage()
{
  return "If you leave this page, your changes will be lost.";
}

