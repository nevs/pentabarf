
var related_event_counter = 0;

function add_related_event(related_event_id)
{
  var row;

  var row_id = related_event_counter;
  related_event_counter++;

  document.getElementById('related_event_table').style.display = "block";
  var root_element = document.getElementById('related_event_table_body');
  
  row = document.createElement("tr");
  row.setAttribute("id","row_"+row_id);
  
  row.appendChild(create_element("select", 0, "related_event["+row_id+"][related_event_id]", event_names, related_event_id));
  row.appendChild(create_element("input", "checkbox", "related_event["+row_id+"][delete]"));
  row.appendChild(create_element("hidden", 0, "").firstChild);
   
  root_element.appendChild(row);

  if (init_done) enable_save_button();
  enumerator();

}


