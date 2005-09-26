
var init_done = false;

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

var tabindex_counter;

function enumerator()
{
  if (!init_done) return;
  tabindex_counter = 1;
  enumerate(document);
}

function enumerate(node)
{
   if (node.hasChildNodes) {
    var node_child = node.firstChild;
    while (node_child!=null) {
      if(node_child.nodeType == 1 && node_child.getAttribute("tabindex") != null) {
        node_child.setAttribute("tabindex", tabindex_counter);
        tabindex_counter++;  
      }
      enumerate(node_child);
      node_child = node_child.nextSibling;
    }
  }
}

