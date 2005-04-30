function clear_tainting()
{
  window.onbeforeunload = null;
}

function enable_save_button()
{
  tainted = true;
  document.getElementById('buttons').style.display = "block";
  window.onbeforeunload = unloadMessage;
}

function register_handler()
{
  // onUpdate handler doesn't work with khtml based browser 
  var agent = navigator.userAgent.toLowerCase();
  if ( agent.indexOf('khtml') != -1 || navigator.appName == 'Konqueror' ) {
    document.getElementById('buttons').style.display = "block";
    return;
  } else {
    document.getElementById('buttons').style.display = "none";
  }

  var key;
  for(key in document.forms['form_content'].elements)
  {
    if (document.forms['form_content'].elements[key].type && 
        document.forms['form_content'].elements[key].type != 'hidden')
    {
      document.forms['form_content'].elements[key].setAttribute('onChange', 'enable_save_button();' + document.forms['form_content'].elements[key].getAttribute('onChange'));
    }
  }
}

function unloadMessage()
{
  var message = "If you leave this page, your changes will be lost.";
  return message;
}
