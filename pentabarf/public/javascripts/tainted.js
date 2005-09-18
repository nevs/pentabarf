
function clear_tainting()
{
  window.onbeforeunload = null;
}

function enable_save_button()
{
  document.getElementById('buttons').style.display = "block";
  window.onbeforeunload = unloadMessage;
}

function unloadMessage()
{
  var message = "If you leave this page, your changes will be lost.";
  return message;
}
