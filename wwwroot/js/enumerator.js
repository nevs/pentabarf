/* 
  enumerates all objects where tabindex is set 
*/

var counter;
var init_done = false;

function enumerator()
{
  if (!init_done) return;
  counter = 1;
  enumerate(document);
}

function enumerate(node)
{
   if (node.hasChildNodes) {
    var node_child = node.firstChild;
    while (node_child!=null) {
      if(node_child.nodeType == 1 && node_child.getAttribute("tabindex") != null) {
        node_child.setAttribute("tabindex", counter);
        counter++;  
      }
      enumerate(node_child);
      node_child = node_child.nextSibling;
    }
  }
}

