
var keyword_counter = 0;

function add_keyword(keyword_id)
{
  var row;

  var row_id = keyword_counter;
  keyword_counter++;

  var root_element = document.getElementById('list_keyword');
  root_element.style.display = "block";
  
  row = document.createElement("li");
  row.setAttribute("id","row_"+row_id);
  row.setAttribute("class","dragable");
  
  /* first elemnt always <div>-element = handle */
  handle = document.createElement("div");
  handle.setAttribute("class","drag-handle");
  row.appendChild(handle);
  
  row.appendChild(create_element("select", 0, "keyword["+row_id+"][keyword_id]", keywords, keyword_id).firstChild);
  row.appendChild(create_element("input", "checkbox", "keyword["+row_id+"][delete]").firstChild);
  row.appendChild(create_element("hidden", 0, "").firstChild);
   
  root_element.appendChild(row);

  rewrite(row);
  redrag(root_element);
  
  if (init_done) enable_save_button();
  enumerator();

}

function rewrite(elem)
{
  root = elem.parentNode;
  var root_name = root.getAttribute("id");

  var i = 0;
  var node = root.firstChild;
  while (node!=null) {
    if(node.nodeType == 1 && node.nodeName != "#text") {
      node.lastChild.setAttribute("id", "rank_"+node.getAttribute("id"));
      node.lastChild.setAttribute("name", "rank_"+node.getAttribute("id"));
      node.lastChild.setAttribute("value", i);
      i += 1;
    }
    node = node.nextSibling;
  }
}

