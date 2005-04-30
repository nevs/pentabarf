var event_person_counter = 0;

function add_event_person(event_person_id, person_id, event_role_id, event_role_state_id, remark)
{
  var table_row, table_data, element;

  var row_id = event_person_counter;
  event_person_counter++;

  document.getElementById('persons_table').style.display = "block";
  table_row = document.createElement("tr");
  table_row.setAttribute("id","row_"+row_id);
  
  if (person_id) {
    element = new_element("a", 0, "event_person[" + row_id + "][link]", p_base + "person/" + person_id );
    element.setAttribute("title", "Go to \""+person_names[person_id]+"\"");
    element.appendChild(new_element("img", 0, "event_person["+row_id+"][image]", p_base + "images/person/" + person_id));
    table_data = document.createElement("td");
    table_data.appendChild(element);
    table_row.appendChild(table_data);
  } else {
    table_row.appendChild(create_element("img", 0, "event_person["+row_id+"][image]", "/images/icon-person-32x32.png"));
  }

  table_row.appendChild(create_element("input", "hidden", "event_person["+row_id+"][event_person_id]", event_person_id));

  if (person_id) {
    element = new_element("input", "hidden", "event_person["+row_id+"][person_id]", person_id);
  } else {
    element = new_element("select", 0, "event_person["+row_id+"][person_id]", person_names, person_id);
  }
  table_data = document.createElement("td");
  table_data.appendChild(element);
  if (person_id) {
    element = document.createTextNode(person_names[person_id]);
    table_data.appendChild(element);
  }
  table_row.appendChild(table_data);


  var role_select = create_element("select", 0, "event_person["+row_id+"][event_role_id]",event_roles,event_role_id);
  role_select.setAttribute("onchange", "event_person_role_changed('"+row_id+"','"+event_role_state_id+"')");
  table_row.appendChild(role_select);
  table_row.appendChild(create_element("select", 0, "event_person["+row_id+"][event_role_state_id]",event_role_states[event_role_id],event_role_state_id));
  
  table_row.appendChild(create_element("input", "text", "event_person["+row_id+"][remark]", remark));
  table_row.appendChild(create_element("input", "checkbox", "event_person["+row_id+"][delete]"));
  document.getElementById("person_table_body").appendChild(table_row);

  event_person_role_changed(row_id,event_role_state_id);

  if (init_done) enable_save_button();
  enumerator();

}


function event_person_role_changed(row_id,event_role_state_id)
{
	
  var select_role = document.getElementById("event_person["+row_id+"][event_role_id]");
  var select_state = document.getElementById("event_person["+row_id+"][event_role_state_id]");
  var select_state_new = create_element("select", 0, "event_person["+row_id+"][event_role_state_id]",event_role_states[select_role.value],event_role_state_id);
  
  select_state.parentNode.parentNode.replaceChild(select_state_new, select_state.parentNode);
  
  if(event_role_states[select_role.value]) {
  	select_state_new.firstChild.style.display = "block";
  } else 
  	select_state_new.firstChild.style.display = "none";

  enumerator();
}
